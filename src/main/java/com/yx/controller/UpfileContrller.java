package com.yx.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
public class UpfileContrller {


    @PostMapping("/updatePersonalById")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file, Model m){
        HashMap<String, Object> map = new HashMap<>();
        try {
            // 获取图片名称
            String fileName = file.getOriginalFilename();
            fileName=changeName(fileName);
            System.out.println(fileName);
            //上传文件存储的位置
            String filePath="D:/IDEAProject/library-system-master/src/main/webapp/images/";
            //图片的名称用于传输到数据库
//防止该文件夹不存在，创建一个新文件夹
            File destFile = new File(filePath,fileName);
//            setPath("/lh/images/"+fileName);
            destFile.getParentFile().mkdirs();
            //将文件存储到该位置
            file.transferTo(destFile);
            String str = "{\"code\": 0,\"msg\": \"\",\"data\": {\"src\":\"" + fileName + "\"}}";
            return str;
        }
        catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static String changeName(String oldName){
         Random r = new Random();
         Date d = new Date();
         String newName = oldName.substring(oldName.indexOf('.'));
         newName = r.nextInt(99999999) + d.getTime() + newName;
         return newName;
     }



}
