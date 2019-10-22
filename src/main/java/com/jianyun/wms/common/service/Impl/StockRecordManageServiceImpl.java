package com.jianyun.wms.common.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jianyun.wms.common.service.Interface.StockRecordManageService;
import com.jianyun.wms.common.service.Interface.StorageManageService;
import com.jianyun.wms.common.util.Response;
import com.jianyun.wms.dao.*;
import com.jianyun.wms.domain.*;
import com.jianyun.wms.exception.StockRecordManageServiceException;
import com.jianyun.wms.exception.StorageManageServiceException;
import com.jianyun.wms.util.IDKeyUtil;
import com.jianyun.wms.util.aop.UserOperation;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class StockRecordManageServiceImpl implements StockRecordManageService {

    @Autowired
    private SupplierMapper supplierMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private RepositoryMapper repositoryMapper;
    @Autowired
    private ShelvesMapper shelvesMapper;
    @Autowired
    private StorageManageService storageManageService;
    @Autowired
    private StockInMapper stockinMapper;
    @Autowired
    private StockOutMapper stockOutMapper;
    @Autowired
    private StorageMapper storageMapper;
    @Autowired
    private MessageMapper messageMapper;

    /**
     * 货物入库操作
     *
     * @param supplierID   供应商ID
     * @param goodsID      货物ID
     * @param repositoryID 入库仓库ID
     * @param number       入库数量
     * @return 返回一个boolean 值，若值为true表示入库成功，否则表示入库失败
     */
    @UserOperation(value = "货物入库")
    @Override
    public boolean stockInOperation(Integer supplierID, Integer goodsID, Integer repositoryID, Integer shelvesID, long number, String personInCharge) throws StockRecordManageServiceException {

        // ID对应的记录是否存在
        if (!(supplierValidate(supplierID) && goodsValidate(goodsID) && repositoryValidate(repositoryID) && ShelvesValidate(shelvesID)))
            return false;

        if (personInCharge == null)
            return false;

        // 检查入库数量有效性
        if (number < 0)
            return false;

        try {
            // 更新库存记录
            boolean isSuccess;
            isSuccess = storageManageService.storageIncrease(goodsID, repositoryID, shelvesID, number);

            // 保存入库记录
            if (isSuccess) {
                StockInDO stockInDO = new StockInDO();
                stockInDO.setId(IDKeyUtil.generateSnowFlakeSnowId().toString());
                stockInDO.setGoodID(goodsID);
                stockInDO.setSupplierID(supplierID);
                stockInDO.setNumber(number);
                stockInDO.setPersonInCharge(personInCharge);
                stockInDO.setTime(new Date());
                stockInDO.setRepositoryID(repositoryID);
                stockInDO.setShelvesID(shelvesID);
                stockinMapper.insert(stockInDO);
            }

            return isSuccess;
        } catch (PersistenceException | StorageManageServiceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    /**
     * 货物出库操作
     *
     * @param customerID   客户ID
     * @param goodsID      货物ID
     * @param repositoryID 出库仓库ID
     * @param number       出库数量
     * @return 返回一个boolean值，若值为true表示出库成功，否则表示出库失败
     */
    @UserOperation(value = "货物出库")
    @Override
    public boolean stockOutOperation(Integer customerID, Integer goodsID, Integer repositoryID, Integer shelvesID, long number, String personInCharge) throws StockRecordManageServiceException {

        // 检查ID对应的记录是否存在
        if (!(customerValidate(customerID) && goodsValidate(goodsID) && repositoryValidate(repositoryID)))
            return false;

        // 检查出库数量范围是否有效
        if (number < 0)
            return false;

        try {
            // 更新库存信息
            boolean isSuccess;
            isSuccess = storageManageService.storageDecrease(goodsID, repositoryID, shelvesID, number);

            // 保存出库记录
            if (isSuccess) {
                StockOutDO stockOutDO = new StockOutDO();
                stockOutDO.setId(IDKeyUtil.generateSnowFlakeSnowId().toString());
                stockOutDO.setCustomerID(customerID);
                stockOutDO.setGoodID(goodsID);
                stockOutDO.setNumber(number);
                stockOutDO.setPersonInCharge(personInCharge);
                stockOutDO.setRepositoryID(repositoryID);
                stockOutDO.setShelvesID(shelvesID);
                stockOutDO.setTime(new Date());
                stockOutMapper.insert(stockOutDO);

                Long stock = storageMapper.queryStorageByGood(goodsID);
                Goods goods = goodsMapper.selectById(goodsID);
                if (stock <= goods.getWarningValue()){
                    Message msg = new Message();
                    msg.setTitle("库存预警");
                    msg.setContent("商品"+goods.getName()+"库存已经不足"+goods.getWarningValue()+",请注意查看");
                    msg.setStatus(0);
                    messageMapper.insert(msg);
                }
            }

            return isSuccess;
        } catch (PersistenceException | StorageManageServiceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    @UserOperation(value = "货物批量出库")
    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public String stockOutOperation(List<StockOutDO> list,String personInCharge) throws StockRecordManageServiceException{
        try {
            String batchId = IDKeyUtil.generateSnowFlakeSnowId().toString();
            Date date = new Date();
            String id;
            Boolean isSuccess = true;
            for (StockOutDO stock:list){
                if (list.size() == 1){
                    id = batchId;
                } else {
                    id = IDKeyUtil.generateSnowFlakeSnowId().toString();
                }
                stock.setId(id);
                stock.setPersonInCharge(personInCharge);
                stock.setTime(date);
                stock.setBatchId(batchId);
                boolean storageDecrease = storageManageService.storageDecrease(stock.getGoodID(), stock.getRepositoryID(), stock.getShelvesID(), stock.getNumber());
                if (!storageDecrease){
                    isSuccess = storageDecrease;
                }
            }

            if (isSuccess){
                stockOutMapper.insertBatch(list);
                for (StockOutDO stockOutDO:list){
                    Integer goodID = stockOutDO.getGoodID();
                    Long stock = storageMapper.queryStorageByGood(goodID);
                    Goods goods = goodsMapper.selectById(goodID);
                    if (stock <= goods.getWarningValue()){
                        Message msg = new Message();
                        msg.setTitle("库存预警");
                        msg.setContent("商品"+goods.getName()+"库存已经不足"+goods.getWarningValue()+",请注意查看");
                        msg.setStatus(0);
                        messageMapper.insert(msg);
                    }
                }
            }else{
                throw new StockRecordManageServiceException();
            }

            if (isSuccess){
                return batchId;
            }else{
                return Response.RESPONSE_RESULT_ERROR;
            }
        }catch (PersistenceException | StorageManageServiceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }


    /**
     * 查询入库记录
     *
     * @param repositoryID 入库仓库ID
     * @param startDateStr    入库记录起始日期
     * @param endDateStr      入库记录结束日期
     * @param offset       分页偏移值
     * @param limit        分页大小
     * @return 返回所有符合要求的入库记录
     */
    public Map<String, Object> selectStockInRecord(Integer repositoryID, String startDateStr, String endDateStr, int offset, int limit) throws StockRecordManageServiceException {
        Map<String, Object> result = new HashMap<>();
        List<StockInDO> stockInRecords;
        long stockInTotal = 0;
        boolean isPagination = true;
        // 转换 Date 对象
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            if (StringUtils.isNotEmpty(startDateStr))
                startDate = dateFormat.parse(startDateStr);
            if (StringUtils.isNotEmpty(endDateStr)) {
                endDate = dateFormat.parse(endDateStr);
            }
        } catch (ParseException e) {
            throw new StockRecordManageServiceException(e);
        }

        // 检查是否需要分页查询
        if (offset < 0 || limit < 0)
            isPagination = false;

        // 查询记录
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                stockInRecords = stockinMapper.selectByRepositoryIDAndDate(repositoryID, startDate, endDate);
                if (stockInRecords != null)
                    stockInTotal = new PageInfo<>(stockInRecords).getTotal();
                else
                    stockInRecords = new ArrayList<>(10);
            } else {
                stockInRecords = stockinMapper.selectByRepositoryIDAndDate(repositoryID, startDate, endDate);
                if (stockInRecords != null)
                    stockInTotal = stockInRecords.size();
                else
                    stockInRecords = new ArrayList<>(10);
            }
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }

        result.put("data", stockInRecords);
        result.put("total", stockInTotal);
        return result;
    }

    /**
     * 查询出库记录
     *
     * @param repositoryID 出库仓库ID
     * @param startDateStr    出库记录起始日期
     * @param endDateStr      出库记录结束日期
     * @param offset       分页偏移值
     * @param limit        分页大小
     * @return 返回所有符合要求的出库记录
     */
    public Map<String, Object> selectStockOutRecord(Integer repositoryID, String startDateStr, String endDateStr, int offset, int limit) throws StockRecordManageServiceException {
        Map<String, Object> result = new HashMap<>();
        List<StockOutDO> stockOutRecords;
        long stockOutRecordTotal = 0;
        boolean isPagination = true;

        // 转换 Date 对象
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            if (StringUtils.isNotEmpty(startDateStr))
                startDate = dateFormat.parse(startDateStr);
            if (StringUtils.isNotEmpty(endDateStr)) {
                endDate = dateFormat.parse(endDateStr);
            }
        } catch (ParseException e) {
            throw new StockRecordManageServiceException(e);
        }

        // 检查是否需要分页
        if (offset < 0 || limit < 0)
            isPagination = false;

        // 查询记录
        try {
            if (isPagination) {
                PageHelper.offsetPage(offset, limit);
                stockOutRecords = stockOutMapper.selectByRepositoryIDAndDate(repositoryID, startDate, endDate);
                if (stockOutRecords != null)
                    stockOutRecordTotal = new PageInfo<>(stockOutRecords).getTotal();
                else
                    stockOutRecords = new ArrayList<>(10);
            } else {
                stockOutRecords = stockOutMapper.selectByRepositoryIDAndDate(repositoryID, startDate, endDate);
                if (stockOutRecords != null)
                    stockOutRecordTotal = stockOutRecords.size();
                else
                    stockOutRecords = new ArrayList<>(10);
            }
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }

        for (StockOutDO record:stockOutRecords){
            if (!record.getId().equals(record.getBatchId())){
                record.setGoodName("多个商品,请查看详情");
                record.setRepository("见详情");
                record.setShelves("见详情");
                record.setNumber(0);
                List<StockOutDO> stockOutDetails = stockOutMapper.selectByBatchId(record.getBatchId());
                record.setDetail(stockOutDetails);
            }
        }

        result.put("data", stockOutRecords);
        result.put("total", stockOutRecordTotal);
        return result;
    }

    private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 检查货物ID对应的记录是否存在
     *
     * @param goodsID 货物ID
     * @return 若存在则返回true，否则返回false
     */
    private boolean goodsValidate(Integer goodsID) throws StockRecordManageServiceException {
        try {
            Goods goods = goodsMapper.selectById(goodsID);
            return goods != null;
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    /**
     * 检查仓库ID对应的记录是否存在
     *
     * @param repositoryID 仓库ID
     * @return 若存在则返回true，否则返回false
     */
    private boolean repositoryValidate(Integer repositoryID) throws StockRecordManageServiceException {
        try {
            Repository repository = repositoryMapper.selectByID(repositoryID);
            return repository != null;
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    private boolean ShelvesValidate(Integer shelvesID) throws StockRecordManageServiceException {
        try {
            Shelves shelves = shelvesMapper.selectById(shelvesID);
            return shelves != null;
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    /**
     * 检查供应商ID对应的记录是否存在
     *
     * @param supplierID 供应商ID
     * @return 若存在则返回true，否则返回false
     */
    private boolean supplierValidate(Integer supplierID) throws StockRecordManageServiceException {
        try {
            Supplier supplier = supplierMapper.selectById(supplierID);
            return supplier != null;
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    /**
     * 检查客户ID对应的记录是否存在
     *
     * @param cumtomerID 客户ID
     * @return 若存在则返回true，否则返回false
     */
    private boolean customerValidate(Integer cumtomerID) throws StockRecordManageServiceException {
        try {
            Customer customer = customerMapper.selectById(cumtomerID);
            return customer != null;
        } catch (PersistenceException e) {
            throw new StockRecordManageServiceException(e);
        }
    }

    private static List<String> getMonthBetween(String minDate, String maxDate) throws Exception {
        ArrayList<String> result = new ArrayList<String>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");//格式化为年月

        Calendar min = Calendar.getInstance();
        Calendar max = Calendar.getInstance();

        min.setTime(sdf.parse(minDate));
        min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);

        max.setTime(sdf.parse(maxDate));
        max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);

        Calendar curr = min;
        while (curr.before(max)) {
            result.add(sdf.format(curr.getTime()));
            curr.add(Calendar.MONTH, 1);
        }

        return result;
    }

    @Override
    public Map<String, Object> queryStatisticalData(Integer goodID, String startDate, String endDate) throws Exception {
        Map<String,Object> result = new HashMap<>();

        Map<String,Object> param = new HashMap<>();
        param.put("goodId",goodID);
        param.put("startDate",startDate);
        param.put("endDate",endDate);
        List<Map<String, Object>> list = stockOutMapper.queryStatisticalDataByGoodIdAndTime(param);
        List<String> monthBetweenList = getMonthBetween(startDate, endDate);
        for (String month:monthBetweenList){
            Boolean isExist = false;
            for (Map map:list){
                String date = map.get("date").toString();
                if (date.equals(month)){
                    isExist = true;
                    break;
                }
            }
            if (!isExist){
                Map<String,Object> map = new HashMap<>();
                map.put("date",month);
                map.put("total",0);
                map.put("price",0);
                list.add(map);
            }
        }
        list.sort(new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                String data1Str = (String) o1.get("date");
                String data2Str = (String) o2.get("date");
                SimpleDateFormat sdf = new  SimpleDateFormat("yyyy-MM");
                Date data1 = null;
                Date date2 = null;
                try {
                    data1 = sdf.parse(data1Str);
                    date2 = sdf.parse(data2Str);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                return data1.compareTo(date2);
            }
        });

        result.put("data", list);
        result.put("total", list.size());
        return result;
    }
}