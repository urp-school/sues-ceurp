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
package org.openurp.sues.edu.grade.helper;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.beangle.commons.collection.CollectUtils;
import org.openurp.edu.grade.course.model.CourseGrade;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class CourseGradeDataHelper {
  public Map<String, Object> courseGradeBy2Semester(List<CourseGrade> courseGrades) {
    Map<String, Object> resultMap = CollectUtils.newHashMap();
    if (CollectionUtils.isNotEmpty(courseGrades)) {
      Set<String> schoolYears = CollectUtils.newHashSet();

      Map<String, Map<String, List<CourseGrade>>> courseGradeMap = CollectUtils.newHashMap();
      for (CourseGrade courseGrade : courseGrades) {
        Calendar beginOn = DateUtils.toCalendar(courseGrade.getSemester().getBeginOn());
        schoolYears.add(courseGrade.getSemester().getSchoolYear());

        String year = courseGrade.getSemester().getSchoolYear();
        if (!courseGradeMap.containsKey(year)) {
          courseGradeMap.put(year, CollectUtils.newHashMap());
        }
        String whichHalf = beginOn.get(2) == 8 ? "firstHalf" : "secondHalf";
        if (!((Map) courseGradeMap.get(year)).containsKey(whichHalf)) {
          ((Map) courseGradeMap.get(year)).put(whichHalf, CollectUtils.newArrayList());
        }
        ((List) ((Map) courseGradeMap.get(year)).get(whichHalf)).add(courseGrade);
      }
      resultMap.put("schoolYears", schoolYears);
      resultMap.putAll(courseGradeMap);
    }
    return resultMap;
  }
}
