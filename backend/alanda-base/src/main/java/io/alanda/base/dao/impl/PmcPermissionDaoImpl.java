/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package io.alanda.base.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import io.alanda.base.dao.AbstractCrudDao;
import io.alanda.base.dao.PmcPermissionDao;
import io.alanda.base.entity.PmcPermission;

/**
 *
 * @author developer
 */
public class PmcPermissionDaoImpl extends AbstractCrudDao<PmcPermission> implements PmcPermissionDao {
  
  public PmcPermissionDaoImpl() {
    super(PmcPermission.class);
  }
  
  public PmcPermissionDaoImpl(EntityManager em) {
    super(em);
  }

  @Override
  public PmcPermission getPermissionByKey(String key) {
    try {
      return em.createNamedQuery("PmcPermission.getPermissionByKey", PmcPermission.class).setParameter("key", key).getSingleResult();
    } catch (NoResultException e) {
      logger.info("getByPermissionKEy: No permission found for " + key);
      return null;
    }
  }
  
}
