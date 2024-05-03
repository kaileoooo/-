package com.yx.controller;


import com.yx.po.BookInfo;
import com.yx.po.BookReader;
import com.yx.po.ReaderInfo;
import com.yx.service.BookInfoService;
import com.yx.service.BookReaderService;
import com.yx.service.ReaderInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.SimpleTypeConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/bookReader")
public class BookReaderController {

    @Autowired
    private BookReaderService bookReaderService;

    @Autowired
    private ReaderInfoService readerInfoService;

    @Autowired
    private BookInfoService bookInfoService;

    /**
     * 类型根据id查询(预约)
     */
    @GetMapping("/queryTypeInfoByReader")
    public String queryTypeInfoByReader(HttpServletRequest request, Integer id, Model model){
        BookInfo bookInfo= bookInfoService.queryBookInfoById(id);
        HttpSession session = request.getSession();
        ReaderInfo readerInfo = (ReaderInfo) session.getAttribute("user");
        BookReader reader=bookReaderService.queryBookReaderInfoById(bookInfo.getId(),readerInfo.getId());
        model.addAttribute("info",reader);
        return "book/bookToReader";
    }

    @RequestMapping("/addBookReader")
    @ResponseBody
    public DataInfo addBookReader(HttpServletRequest request,@RequestBody BookReader info){
        HttpSession session = request.getSession();
        ReaderInfo readerInfo = (ReaderInfo) session.getAttribute("user");

        ReaderInfo reInfo = readerInfoService.queryReaderInfoById(readerInfo.getId());
        if (reInfo.getMenberTime()==null){
            return DataInfo.fail("您不是会员，无法预约，请充值");
        }
        if (reInfo.getMenberTime().before(new Date())){
            return DataInfo.fail("您的会员已过期，请充值");
        }
        info.setReaderId(readerInfo.getId());
        info.setStatus(0);
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyyMMddHHmmss");
        info.setOrderNum(simpleDateFormat.format(new Date()));
        bookReaderService.addBookReader(info);
        return DataInfo.ok();
    }



}
