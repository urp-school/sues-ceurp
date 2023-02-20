/*
 * OpenURP, Agile University Resource Planning Solution.
 *
 * Copyright © 2014, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful.
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.openurp.sues.edu.grade.transcript.service.impl;

import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.collection.Order;
import org.beangle.commons.dao.EntityDao;
import org.beangle.commons.dao.query.builder.OqlBuilder;
import org.openurp.base.edu.model.Semester;
import org.openurp.base.std.model.Student;
import org.openurp.edu.grade.transcript.service.TranscriptDataProvider;

import java.util.List;
import java.util.Map;

public class TranscriptNextSemesterProvider implements TranscriptDataProvider {
  private EntityDao entityDao;

  public Object getDatas(List<Student> stds, Map<String, String> options) {
    Map semestersMap = CollectUtils.newHashMap();

    List<Semester> semesters = this.entityDao.search(OqlBuilder.from(Semester.class, "semester").orderBy(
        Order.parse("semester.beginOn")));
    for (int i = 0; i < semesters.size(); i++) {
      Map<String, Semester> semesterMap = CollectUtils.newHashMap();
      semesterMap.put("next", i + 1 < semesters.size() ? (Semester) semesters.get(i + 1) : null);
      semestersMap.put(((Integer) ((Semester) semesters.get(i)).getId()).toString(), semesterMap);
    }
    return semestersMap;
  }

  public String getDataName() {
    return "semesterMap";
  }

  public void setEntityDao(EntityDao entityDao) {
    this.entityDao = entityDao;
  }
}
