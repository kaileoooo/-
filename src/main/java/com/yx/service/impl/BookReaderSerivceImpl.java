package com.yx.service.impl;

import com.yx.dao.BookInfoMapper;
import com.yx.po.BookInfo;
import com.yx.po.BookReader;
import com.yx.po.BookReaderReq;
import com.yx.service.BookReaderService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class BookReaderSerivceImpl implements BookReaderService {

    @Autowired
    private BookInfoMapper bookReaderMapper;

    @Override
    public BookReaderReq queryBookReaderInfoById(Integer bookId, Integer readerId) {
        BookReaderReq bookReader=bookReaderMapper.queryBookReaderInfoById(bookId,readerId);
        return bookReader;
    }

    @Override
    public void addBookReader(BookReader info) {
        bookReaderMapper.addBookReader(info);
    }

    @Override
    public List<BookReader> getBookReaderList(Integer id) {
        return bookReaderMapper.getBookReaderList(id);
    }

    @Override
    public void removeSub(int id) {
        bookReaderMapper.removeSub(id);
    }

    @Override
    public BookReader getBook(Integer id) {
        return bookReaderMapper.getBookById(id);
    }

    @Override
    public DataInfo getBookSubmit(BookReader bookReader) {
        BookReader bookById = bookReaderMapper.getOne(bookReader.getId());
        if (bookById.getOrderNum().equals(bookReader.getOrderNum())){
            if (bookById.getStartTime().before(new Date()) && bookById.getEndTime().after(new Date())){
                bookReaderMapper.getBookSubmit(bookReader.getId());
                return DataInfo.ok();
            }
            return DataInfo.fail("不在取书时间范围内");
        }
        return DataInfo.fail("订单编号错误");
    }
}
