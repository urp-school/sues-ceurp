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
package org.openurp.sues.edu.grade.gpa.policy;

import org.beangle.commons.collection.CollectUtils;
import org.openurp.edu.grade.course.model.CourseGrade;
import org.openurp.edu.grade.course.service.impl.GradeFilter;

import java.util.List;

public class NoPassedElectiveFilter implements GradeFilter {
  public List<CourseGrade> filter(List<CourseGrade> grades) {
    List<CourseGrade> noPassedGrades = CollectUtils.newArrayList();
    for (CourseGrade grade : grades) {
      if ((grade.isPassed()) || (!((Integer) grade.getCourseType().getId()).equals(Integer.valueOf(40)))) {
        noPassedGrades.add(grade);
      }
    }
    return noPassedGrades;
  }
}
