package com.yx.service;

import com.yx.po.BookInfo;
import com.yx.po.BookReader;
import com.yx.po.BookReaderReq;
import com.yx.utils.DataInfo;

import java.util.List;

public interface BookReaderService {
    BookReaderReq queryBookReaderInfoById(Integer bookId, Integer readerId);

    void addBookReader(BookReader info);

    List<BookReader> getBookReaderList(Integer id);

    void removeSub(int id);

    BookReader getBook(Integer id);

    DataInfo getBookSubmit(BookReader bookReader);
}
