package com.ssmc.controller;

import com.ssmc.entity.Work;
import com.ssmc.service.WorkService;
import com.ssmc.service.impl.ExecuteCLangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/code")
public class ClangController {
    @Resource
    private WorkService workService;

    private static final String DEFAULT_CLANG_SOURCE_CODE = "#include <stdio.h>\n" +
            "int main(){\n" +
            "\tprintf(\"Hello world!\");\n" +
            "\treturn 0;\n" +
            "}";


//    ExecuteCLangService cLangService = new ExecuteCLangService();
    @Autowired
    ExecuteCLangService cLangService;



//    @RequestMapping("/page")
//    public String testpage(Model model){
//        return "clang";
//    }

    @RequestMapping("/clang")
    public String toCLangPage(Model model){
        model.addAttribute("lastSourceCode",DEFAULT_CLANG_SOURCE_CODE);
        return "clang";
    }

    @RequestMapping("/workDetail")
    public String toWorkDetail(Integer workId,Model model){
        Work work = workService.findWorksById(workId);
        model.addAttribute("work",work);
        model.addAttribute("lastSourceCode",DEFAULT_CLANG_SOURCE_CODE);
        return "workdetail";
    }

    @RequestMapping("/clang1")
    public String toCLangPage1(Model model){
        model.addAttribute("lastSourceCode",DEFAULT_CLANG_SOURCE_CODE);
        return "clang1";
    }

    @RequestMapping("/runCLang1")
    public String runCLang1(@RequestParam("sourceCode") String sourceCode,
                           Model model,
                           HttpServletRequest request){
//        synDataBase(sourceCode,"C",request);
        System.out.println("input test:\n"+sourceCode);
        String result = cLangService.getRunResult(sourceCode);
        model.addAttribute("lastSourceCode",sourceCode);
        model.addAttribute("runResult",result);
        return "clang1";
    }

    @RequestMapping("/runCLang")
    public String runCLang(@RequestParam("sourceCode") String sourceCode,
                           Model model,
                           HttpServletRequest request){
//        synDataBase(sourceCode,"C",request);
        System.out.println("input test:\n"+sourceCode);
        String result = cLangService.getRunResult(sourceCode);
        model.addAttribute("lastSourceCode",sourceCode);
        model.addAttribute("runResult",result);
        return "clang";
    }
    //test
    @RequestMapping("/runCLang2")
    public String runCLang2(@RequestParam("sourceCode") String sourceCode,Integer workId,
                           Model model,
                           HttpServletRequest request){
//        synDataBase(sourceCode,"C",request);
        Work work = workService.findWorksById(workId);
        model.addAttribute("work",work);
        System.out.println("input test:\n"+sourceCode);
        String result = cLangService.getRunResult(sourceCode);
        model.addAttribute("lastSourceCode",sourceCode);
        model.addAttribute("runResult",result);
        return "workdetail";
    }

//    private void synDataBase(String sourceCode,String language,HttpServletRequest request){
//        //如果redis数据和mysql不一致，将不一致的数据更新至redis
//        String userid = getUserId(request);
//        userService.runCode(new RunRecord(userid,sourceCode,TimeUtils.getTimeInfo(),language));
//        List<RunRecord> recordMysql = userService.queryRecord(userid);
//        List<String> recordRedis = redisUtil.lRange(KEY_PREFIX_CODE+userid,0,-1);
//        redisUtil.expire(KEY_PREFIX_CODE+userid,1*60);
//        redisUtil.expire(KEY_PREFIX_LANG+userid,1*60);
//        redisUtil.expire(KEY_PREFIX_TIME+userid,1*60);
//        try {
//            int offset = recordMysql.size()-recordRedis.size();
//            if (offset!=0){
//                clearRedis(userid);
//                for (int i = 0;i < recordMysql.size();i++){
//                    redisUtil.rPush(KEY_PREFIX_CODE+userid,recordMysql.get(i).getCode());
//                    redisUtil.rPush(KEY_PREFIX_TIME+userid,recordMysql.get(i).getTimedetail());
//                    redisUtil.rPush(KEY_PREFIX_LANG+userid,recordMysql.get(i).getLanguage());
//                }
//                log.info("redis data is different from mysql");
//                //System.out.println("Redis和Mysql的数据不一致");
//            }
//        }catch (NullPointerException e){
//            log.info("null pointer");
//        }
//    }
}
