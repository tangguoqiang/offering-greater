package com.offering.core.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.offering.bean.Activity;
import com.offering.bean.ChartGroup;
import com.offering.bean.PageInfo;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.Utils;
import com.offering.core.service.ActivityService;

/**
 * 活动入口
 * @author surfacepro3
 *
 */
@Controller
@RequestMapping(value ="/activity")
public class ActivityController {

	private final static Logger LOG = Logger.getLogger(ActivityController.class);
	
	@Autowired
	private ActivityService activityService;
	
	/**
	 * 查询活动数据
	 * @param act
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/listActivities", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listActivities(String createrId){
		Map<String, Object> m = new HashMap<String, Object>();
		List<Activity> l = activityService.listActivities(createrId);
		m.put("records", l);
//		m.put("totalCount", activityService.getActivityCount(act));
		return m;
	}
	
	/**
	 * 发布活动
	 * @param user
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/releaseActivity", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> releaseActivity(Activity act) throws ParseException{
		Map<String, Object> m = new HashMap<String, Object>();
		act.setStatus(GloabConstant.ACTIVITY_STATUS_CG);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		if(!Utils.isEmpty(act.getStartTime()))
		{
			act.setStartTime(sdf.parse(act.getStartTime()).getTime() + "");
		}
		
		if(!Utils.isEmpty(act.getEndTime()))
		{
			act.setEndTime(sdf.parse(act.getEndTime()).getTime() + "");
		}
		
		ChartGroup group = new ChartGroup();
		group.setGroupName(act.getTitle());
		group.setGroupInfo("");
		if(Utils.isEmpty(act.getId())){
			//新增活动
			group.setCreateTime(System.currentTimeMillis() + "");
			activityService.insertActivity(act,group);
		}else{
			//更新活动
			activityService.updateActivity(act,group);
		}
		m.put("success", true);
		return m;
	}
	
	/**
	 * 查询活动数据
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getActivityInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getActivityInfo(String id){
		Map<String, Object> m = new HashMap<String, Object>();
		//TODO 多表关联查询结构有待优化
		Activity act = activityService.getActivityById(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-DD HH:mm");
		if(act != null)
		{
			m.put("id", act.getId());
			m.put("title", act.getTitle());
			m.put("type", act.getType());
			if(!Utils.isEmpty(act.getStartTime()))
				act.setStartTime(sdf.format(new Date(Long.valueOf(act.getStartTime()))));
			if(!Utils.isEmpty(act.getEndTime()))
				act.setEndTime(sdf.format(new Date(Long.valueOf(act.getEndTime()))));
			m.put("startTime", act.getStartTime());
			m.put("endTime", act.getEndTime());
		}
		
		ChartGroup group = activityService.getGroupById(id);
		if(group != null)
		{
			m.put("groupName", group.getGroupName());
			m.put("groupInfo", group.getGroupInfo());
		}
		return m;
	}
	
	/**
	 * 上传头像
	 * @param req
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadImage(HttpServletRequest req){
		 DiskFileItemFactory factory = new DiskFileItemFactory();  
       //设置暂时存放文件的存储室，这个存储室可以和最终存储文件的文件夹不同。因为当文件很大的话会占用过多内存所以设置存储室。  
       factory.setRepository(new File(GloabConstant.ROOT_DIR + "tmp"));  
       //设置缓存的大小，当上传文件的容量超过缓存时，就放到暂时存储室。  
       factory.setSizeThreshold(1024*1024);  
       //上传处理工具类（高水平API上传处理？）  
       ServletFileUpload upload = new ServletFileUpload(factory);  
	    upload.setSizeMax(10*1024*1024);   // 设置允许用户上传文件大小,单位:字节 10M
	    Map<String, String> paramMap = new HashMap<String, String>();
	    String filename = null;
	    OutputStream out  = null;
	    try{
	    	List<FileItem> list = (List<FileItem>)upload.parseRequest(req);  
	    	for(FileItem item:list){  
	    		String name = item.getFieldName();  
	    		if(item.isFormField()){  
	    			//如果获取的表单信息是普通的文本信息。即通过页面表单形式传递来的字符串。  
	    			String value = item.getString();  
	    			paramMap.put(name, value);
	    		}else{   
	            	//如果传入的是非简单字符串，而是图片，音频，视频等二进制文件。  
	                String value = item.getName();  
	                filename = value.substring(value.lastIndexOf("\\") + 1);  
	                filename = "activity_" + System.currentTimeMillis() + filename.substring(filename.indexOf("."));
	                LOG.info("获取文件总量的容量:"+ item.getSize());  
	                InputStream in = item.getInputStream();  
	                out = new FileOutputStream(
		            		new File(GloabConstant.ROOT_DIR + "userImages",filename));
					int length = 0;  
		            byte[] buf = new byte[1024];  
		            while((length = in.read(buf))!=-1){  
		                out.write(buf,0,length);  
		            }  
	    		}  
	    	}  
	    }catch(Exception e){  
	    	LOG.error(e.getMessage());
	    }  
	    finally{
	    	if(out != null)
				try {
					out.close();
				} catch (IOException e) {
					LOG.error(e.getMessage());
				}
	    }
	    
	    String id = paramMap.get("id");
	    String uploadType = paramMap.get("uploadType");
	    
	    Activity act = activityService.getActivityById(id);
	    if("0".equals(uploadType))
	    {
	    	//活动图片
	    	if(!Utils.isEmpty(act.getUrl()))
	    	{
	    		File tmpFile = new File(GloabConstant.ROOT_DIR + "userImages" 
	    				,act.getUrl().substring(act.getUrl().lastIndexOf("/") + 1));
	    		if(tmpFile.exists())
	    		{
	    			tmpFile.delete();
	    		}
	    	}
	    }else if("1".equals(uploadType)){
	    	//活动分享图片
	    	if(!Utils.isEmpty(act.getShare_activity_image()))
	    	{
	    		File tmpFile = new File(GloabConstant.ROOT_DIR + "userImages" 
	    				,act.getShare_activity_image().substring(act.getShare_activity_image().lastIndexOf("/") + 1));
	    		if(tmpFile.exists())
	    		{
	    			tmpFile.delete();
	    		}
	    	}
	    }else if("2".equals(uploadType)){
	    	//群分享图片
	    	ChartGroup group = activityService.getGroupById(id);
	    	if(!Utils.isEmpty(group.getShare_group_image()))
	    	{
	    		File tmpFile = new File(GloabConstant.ROOT_DIR + "userImages" 
	    				,group.getShare_group_image().substring(group.getShare_group_image().lastIndexOf("/") + 1));
	    		if(tmpFile.exists())
	    		{
	    			tmpFile.delete();
	    		}
	    	}
	    }
	    
	    String url = "/download/userImages/" + filename;
	    activityService.uploadActivityImage(id,url,uploadType);
	    
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		return m;
	}
}
