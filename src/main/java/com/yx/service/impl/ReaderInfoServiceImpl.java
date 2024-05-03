package com.yx.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yx.dao.ReaderInfoMapper;
import com.yx.po.ReaderInfo;
import com.yx.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service("readerInfoService")
public class ReaderInfoServiceImpl implements ReaderInfoService {

    @Autowired
    private ReaderInfoMapper readerInfoMapper;

    @Override
    public PageInfo<ReaderInfo> queryAllReaderInfo(ReaderInfo readerInfo, Integer pageNum, Integer limit) {
        PageHelper.startPage(pageNum,limit);
        List<ReaderInfo> readerInfoList =  readerInfoMapper.queryAllReaderInfo(readerInfo);
        return new PageInfo<>(readerInfoList);
    }

    @Override
    public void addReaderInfoSubmit(ReaderInfo readerInfo) {
        readerInfoMapper.insert(readerInfo);
    }

    @Override
    public ReaderInfo queryReaderInfoById(Integer id) {
        return readerInfoMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateReaderInfoSubmit(ReaderInfo readerInfo) {
        readerInfoMapper.updateByPrimaryKey(readerInfo);
    }

    @Override
    public void deleteReaderInfoByIds(List<String> ids) {
        for (String id : ids){
            readerInfoMapper.deleteByPrimaryKey(Integer.parseInt(id));
        }
    }

    @Override
    public ReaderInfo queryUserInfoByNameAndPassword(String username, String password) {
        return readerInfoMapper.queryUserInfoByNameAndPassword(username, password);
    }

    @Override
    public ReaderInfo queryReaderInfo(Integer id) {
        return null;
    }

    @Override
    public void addReaderMemberTime(ReaderInfo readerInfo, String type) {
        ReaderInfo info = readerInfoMapper.selectByPrimaryKey(readerInfo.getId());
        Date date = getDate(info.getMenberTime(), type);
        info.setMenberTime(date);
        readerInfoMapper.updateByPrimaryKeySelective(info);
    }

    public static Date getDate(Date date,String type){
        Calendar calendar=Calendar.getInstance();
        if (date==null){
            calendar.setTime(new Date());
        }else{
            calendar.setTime(date);
        }
        if ("month".equals(type)){
            calendar.add(Calendar.MONTH,1);
        }else if("quarter".equals(type)){
            calendar.add(Calendar.MONTH,3);
        }else if("year".equals(type)){
            calendar.add(Calendar.YEAR,1);
        }
        return calendar.getTime();
    }

}
