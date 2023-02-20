[#ftl]
[@b.head/]
[#assign _pageSize = 50/]
[#assign gradePerColumn = (_pageSize / 2)?int/]
[#assign fontSize = 10/]
[#assign style]style="font-size: ${fontSize}pt;font-weight: bolder;font-family:黑体;"[/#assign]
[#assign width = "10mm"/]
<style>
table.listTable {
  font-family: Microsoft YaHei;
  border-collapse: collapse;
  border-style:solid;
  border-width:1px;
  vertical-align: middle;
  font-style: normal;
  text-align: center;
  width: 277mm;
}
table.listTable td{
  border-style:solid;
  border-width:1px;
  padding: 0px;
  font-size:${fontSize-2}pt;
}
table.listTable tr{
  height: 20px;
}
@page{
   size: landscape;
}
</style>
[#assign semesterMap={"1":"1st","2":'2nd'} /]

[#list students as std]
  <div style="text-align: center;"><img src="${base}/static/images/schoolName.jpg" style="height:40px;margin-top: 30px;"></div>
  <div align='center' style="font-size:${fontSize+2}pt;font-weight: bolder;font-family:Microsoft YaHei;margin-top: 10px;margin-bottom: 10px;">
  Minor Course Academic Achievements
  </div>
  <div align='right' style="font-size:${fontSize}pt;font-family:Microsoft YaHei;margin-top: 10px;margin-bottom: 10px;margin-left: auto;margin-right: auto;width: 277mm" >Length of schooling：3 years</div>
  <table class="listTable" style="margin: auto">
    <tr>
      <td colspan="2">Name</td>
      <td colspan="2">${std.enName!std.name}</td>
      <td>Gender</td>
      <td>${std.person.gender.enName!std.person.gender.name}</td>
      <td colspan="2">University</td>
      <td colspan="4">${(majorStudents.get(std).school.enName)!"--"}</td>
      <td colspan="2">Student No</td>
      <td colspan="4">${(majorStudents.get(std).code)!"--"}</td>
    </tr>
    <tr>
      <td  colspan="2">Major</td>
      <td colspan="4">${(majorStudents.get(std).enMajorName)!"--"}</td>
      <td colspan="2">Minor</td>
      <td colspan="4">${std.state.major.enName!std.state.major.name}</td>
      <td colspan="2">Minor Student No</td>
      <td colspan="4">${std.code}</td>
    </tr>

    [#assign stdGrades = grades.get(std)/]
    [#assign result = semesterGroup.courseGradeBy2Semester(stdGrades)/]
    [#assign schoolYears = (result.schoolYears?sort)?if_exists/]
    [#assign YearMap={'0':'First School Year','1':'Second School Year','2':'Third School Year'}/]
    <tr valign="top">
      [#list schoolYears as schoolYear]
        [#assign firstHalf = (result[schoolYear].firstHalf?sort_by(["course","code"]))?if_exists/]
        [#assign secondHalf = (result[schoolYear].secondHalf?sort_by(["course","code"]))?if_exists/]
        [#assign firstRow = (firstHalf?size)?default(0)/]
        [#assign secondRow = (secondHalf?size)?default(0)/]
        <td colspan="6">
          <table style="font-size:${fontSize-2}pt;min-width: 92mm;border-style: hidden;" >
          [#if firstRow>0]
            <tr align="center">
              <td colspan="5">${(YearMap[schoolYear_index?string])!}</td>
            </tr>
            <tr align="center">
              <td colspan="5" >(${(firstHalf[0].semester.beginOn?string("yyyy.MM"))!}--${(firstHalf[0].semester.endOn?string("yyyy.MM"))!})</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >Course Name</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
              <td colspan="2" >${semesterMap[firstHalf[0].semester.name]}</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">Score</td>
              <td  style="white-space: nowrap; width:${width}">GPA</td>
            </tr>
            [#list 0..firstRow - 1 as rowIndex]
              <tr>
                <td style="text-align: left">${(firstHalf[rowIndex].course.name)!}</td>
                <td>${(firstHalf[rowIndex].course.creditHours)!}</td>
                <td>${(firstHalf[rowIndex].course.defaultCredits)!}</td>
                <td>${(firstHalf[rowIndex].scoreText)!}</td>
                <td>${(firstHalf[rowIndex].gp)!}</td>
              </tr>
            [/#list]
            [#if firstRow<6]
              [#list firstRow..5 as i]
                <tr style="height: 20px">
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              [/#list]
            [/#if]
          [#else ]
            <tr align="center">
              <td colspan="5" >${(YearMap[schoolYear_index?string])!}</td>
            </tr>
            <tr align="center">
              <td colspan="5"  style="font-size:${fontSize+2}pt">Blank Below</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >Course Name</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
              <td colspan="2" >${semesterMap[firstHalf[0].semester.name]}</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">Score</td>
              <td  style="white-space: nowrap; width:${width}">GPA</td>
            </tr>
            [#list 0..6 as rowIndex]
              <tr style="height: 20px">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            [/#list]
          [/#if]
          [#if secondRow>0]
            <tr align="center">
              <td colspan="5">${(YearMap[schoolYear_index?string])!}</td>
            </tr>
            <tr align="center">
              <td colspan="5" >(${(secondHalf[0].semester.beginOn?string("yyyy.MM"))!}--${(secondHalf[0].semester.endOn?string("yyyy.MM"))!})</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >Course Name</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
              <td colspan="2" >${semesterMap[secondHalf[0].semester.name]}</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">Score</td>
              <td  style="white-space: nowrap; width:${width}">GPA</td>
            </tr>
            [#list 0..secondRow - 1 as rowIndex]
              <tr>
                <td style="text-align: left">[#if secondHalf[rowIndex]??]${secondHalf[rowIndex].course.enName!secondHalf[rowIndex].course.name}[/#if]</td>
                <td>${(secondHalf[rowIndex].course.creditHours)!}</td>
                <td>${(secondHalf[rowIndex].course.defaultCredits)!}</td>
                <td>${(secondHalf[rowIndex].scoreText)!}</td>
                <td>${(secondHalf[rowIndex].gp)!}</td>
              </tr>
            [/#list]
            [#if secondRow<6]
              [#list secondRow..5 as i]
                <tr style="height: 20px">
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              [/#list]
            [/#if]
          [#else ]
            <tr align="center" style="height: 40px">
              <td colspan="5"  style="font-size:${fontSize+2}pt">Blank Below</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >Course Name</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
              <td colspan="2" >2nd</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">Score</td>
              <td  style="white-space: nowrap; width:${width}">GPA</td>
            </tr>
            [#list 0..5 as rowIndex]
              <tr style="height: 20px">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            [/#list]
          [/#if]
          </table>
        </td>
      [/#list]

      [#if schoolYears?size<3]
        [#list 0..2 - schoolYears?size as i]
          <td colspan="6">
            <table style="font-size:${fontSize-2}pt;min-width: 92mm;border-style: hidden;" >
              <tr align="center" style="height: 40px">
                <td colspan="5" style="font-size:${fontSize+2}pt">Blank Below</td>
              </tr>
              <tr align="center">
                <td rowspan="2" >Course Name</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
                <td colspan="2" >1st</td>
              </tr>
              <tr align="center">
                <td  style="white-space: nowrap; width:${width}">Score</td>
                <td  style="white-space: nowrap; width:${width}">GPA</td>
              </tr>
              [#list 0..5 as rowIndex]
                <tr style="height: 20px">
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              [/#list]
              <tr align="center" style="height: 40px">
                <td colspan="5"  style="font-size:${fontSize+2}pt">Blank Below</td>
              </tr>
              <tr align="center">
                <td rowspan="2" >Course Name</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">Hours</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">Credits</td>
                <td colspan="2" >2nd</td>
              </tr>
              <tr align="center">
                <td  style="white-space: nowrap; width:${width}">Score</td>
                <td  style="white-space: nowrap; width:${width}">GPA</td>
              </tr>
              [#list 0..5 as rowIndex]
                <tr style="height: 20px">
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              [/#list]
            </table>
          </td>
        [/#list]
      [/#if]
    </tr>
    <tr>
      <td colspan="12"></td>
      <td colspan="2"><b>GPA</b></td>
      <td colspan="4">${(gpas.get(std).gpa)!}</td>
    </tr>
  </table>
  <table style="font-size:${fontSize-2}pt;margin: auto" class="listTable">
    <tr align="center" style="border-top: none">
      <td rowspan="3">The Method<br> of Calculating GPA</td>
      [#list 0..4 as i ]
        <td style="border: none">Scores</td>
        <td style="border: none">Grade</td>
        <td style="border: none">GPA</td>
      [/#list]
    </tr>
    <tr align="center">
      <td style="border-right: none;border-left: none;">100-90</td>
      <td style="border-right: none;border-left: none;">A</td>
      <td style="border-right: none;border-left: none;">4.0</td>
      <td style="border-right: none;border-left: none;">89-85</td>
      <td style="border-right: none;border-left: none;">A-</td>
      <td style="border-right: none;border-left: none;">3.7</td>
      <td style="border-right: none;border-left: none;">84-82</td>
      <td style="border-right: none;border-left: none;">B+</td>
      <td style="border-right: none;border-left: none;">3.3</td>
      <td style="border-right: none;border-left: none;">81-78</td>
      <td style="border-right: none;border-left: none;">B</td>
      <td style="border-right: none;border-left: none;">3.0</td>
      <td style="border-right: none;border-left: none;">77-75</td>
      <td style="border-right: none;border-left: none;">B-</td>
      <td style="border-right: none;border-left: none;">2.7</td>
    </tr>
    <tr align="center">
      <td style="border-right: none;border-left: none;">74-71</td>
      <td style="border-right: none;border-left: none;">C+</td>
      <td style="border-right: none;border-left: none;">2.3</td>
      <td style="border-right: none;border-left: none;">70-66</td>
      <td style="border-right: none;border-left: none;">C</td>
      <td style="border-right: none;border-left: none;">2.0</td>
      <td style="border-right: none;border-left: none;">65-62</td>
      <td style="border-right: none;border-left: none;">C-</td>
      <td style="border-right: none;border-left: none;">1.5</td>
      <td style="border-right: none;border-left: none;">61-60</td>
      <td style="border-right: none;border-left: none;">D</td>
      <td style="border-right: none;border-left: none;">1.0</td>
      <td style="border-right: none;border-left: none;">Under 60</td>
      <td style="border-right: none;border-left: none;">F</td>
      <td style="border-right: none;border-left: none;">0</td>
    </tr>
  </table>

[/#list]

[@b.foot/]
