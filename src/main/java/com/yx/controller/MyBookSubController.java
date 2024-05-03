package com.yx.controller;

import com.yx.po.BookInfo;
import com.yx.po.BookReader;
import com.yx.po.ReaderInfo;
import com.yx.service.BookReaderService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MyBookSubController {

    @Autowired
    private BookReaderService bookReaderService;

    @RequestMapping("/myBookSub")
    public String bookReader(HttpServletRequest request, Model model){

        return "reader/myBookSub";
    }

    @RequestMapping("/bookReaderList")
    @ResponseBody
    public DataInfo bookReaderList(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        ReaderInfo readerInfo = (ReaderInfo) session.getAttribute("user");
        List<BookReader> list=bookReaderService.getBookReaderList(readerInfo.getId());
//        model.addAttribute("info",list);
        return DataInfo.ok("成功",list);
    }

    @RequestMapping("/removeSub")
    @ResponseBody
    public DataInfo removeSub(String ids){
        bookReaderService.removeSub(Integer.parseInt(ids));
//        model.addAttribute("info",list);
        return DataInfo.ok();
    }

    /**
     * 取书页面
     */
    @GetMapping("/getBook")
    public String getBook(Integer id, Model model){
        BookReader bookInfo= bookReaderService.getBook(id);
        model.addAttribute("info",bookInfo);
        return "reader/getBook";
    }

    @PostMapping("/getBookSubmit")
    @ResponseBody
    public DataInfo getBookSubmit(@RequestBody BookReader bookReader){
        return bookReaderService.getBookSubmit(bookReader);
    }


}
