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

import org.beangle.commons.dao.EntityDao;
import org.openurp.base.std.model.Student;
import org.openurp.edu.grade.transcript.service.TranscriptDataProvider;
import org.openurp.std.info.model.MajorStudent;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MajorStudentProvider implements TranscriptDataProvider {
  private EntityDao entityDao;

  public Object getDatas(List<Student> stds, Map<String, String> options) {
    Map<Student, MajorStudent> majorStudents = new HashMap();
    for (Student std : stds) {
      List<MajorStudent> mss = this.entityDao.get(MajorStudent.class, "std", new Object[]{std});
      if (!mss.isEmpty()) {
        majorStudents.put(std, (MajorStudent) mss.get(0));
      }
    }
    return majorStudents;
  }

  public String getDataName() {
    return "majorStudents";
  }

  public void setEntityDao(EntityDao entityDao) {
    this.entityDao = entityDao;
  }
}
