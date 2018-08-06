package com.echarts.action;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import com.echarts.po.EchartsPo;
import com.opensymphony.xwork2.ActionSupport;




public class EchartsAction extends ActionSupport{
		public void find() throws Exception {
			
			Configuration cfg=new Configuration().configure("/hibernate.cfg.xml");
			ServiceRegistry registry = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties()).build();
			SessionFactory sf = cfg.buildSessionFactory(registry);
			Session session=sf.openSession();
			Query query=session.createQuery("from EchartsPo");
			List<EchartsPo> list=query.list();
			JSONArray json=JSONArray.fromObject(list);
			
			HttpServletResponse hsr=ServletActionContext.getResponse();
			hsr.setCharacterEncoding("UTF-8");
			hsr.getWriter().write(json.toString());
		}
}
