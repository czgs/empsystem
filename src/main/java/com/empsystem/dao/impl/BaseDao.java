package com.empsystem.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class BaseDao {

    //声明SessionFactory
    @Resource
    private SessionFactory sessionFactory;

    /**
     * 添加对象的方法
     * @param obj
     * @return
     */
    public boolean addObject(Object obj){
        try {
            getSession().save(obj);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 修改对象的方法
     *
     * @param obj 对象
     * @return true or false
     */
    public boolean updateObject(Object obj) {
        try {
            getSession().update(obj);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 删除对象的方法
     *
     * @param obj 对象
     * @return true or false
     */
    public boolean deleteObject(Object obj) {
        try {
            getSession().delete(obj);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 查询对象
     *
     * @param hql 查询语句
     * @return 对象集合
     */
    public List<Object> findObjectList( String hql) {
        try {
            return getSession().createQuery(hql).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 通过对象id获取对象
     *
     * @param cls 对象的原型
     * @param id  对象id
     * @return 对象
     */
    public Object getObjectById(Class cls, int id) {
        try {
            return getSession().get(cls, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void setSessionFactory( SessionFactory sessionFactory ) {
        this.sessionFactory = sessionFactory;
    }

    //获取Session
    public Session getSession(){
        return sessionFactory.getCurrentSession();
    }

}
