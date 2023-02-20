[#ftl]
[@b.head/]
[#assign _pageSize = 50/]
[#assign gradePerColumn = (_pageSize / 2)?int/]
[#assign fontSize = 10/]
[#assign style]style="font-size: ${fontSize}pt;font-weight: bolder;font-family:黑体;"[/#assign]
[#assign width = "10mm"/]
<style>
table.listTable {
  font-family: 宋体;
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

[#list students as std]
  <div style="text-align: center;"><img src="${base}/static/images/schoolName.jpg" style="height:40px;margin-top: 30px;"></div>
  <div align='center' style="font-size:${fontSize+2}pt;font-weight: bolder;font-family:宋体;margin-top: 10px;margin-bottom: 10px;">辅修专业课程修读成绩单</div>
  <div align='right' style="font-size:${fontSize}pt;font-family:宋体;margin-top: 10px;margin-bottom: 10px;margin-left: auto;margin-right: auto;width: 277mm" >学制：叁年制</div>
  <table class="listTable" style="margin: auto">
    <tr>
      <td colspan="2">姓名</td>
      <td colspan="2">${std.name}</td>
      <td>性别</td>
      <td>${(std.person.gender.name)!}</td>
      <td colspan="2">主修学校</td>
      <td colspan="4">${(majorStudents.get(std).school.name)!"--"}</td>
      <td colspan="2">学号</td>
      <td colspan="4">${(majorStudents.get(std).code)!"--"}</td>
    </tr>
    <tr>
      <td  colspan="2">主修专业</td>
      <td colspan="4">${(majorStudents.get(std).majorName)!"--"}</td>
      <td colspan="2">辅修专业</td>
      <td colspan="4">${std.state.major.name}</td>
      <td colspan="2">辅修学号</td>
      <td colspan="4">${std.code}</td>
    </tr>

    [#assign stdGrades = grades.get(std)/]
    [#assign result = semesterGroup.courseGradeBy2Semester(stdGrades)/]
    [#assign schoolYears = (result.schoolYears?sort)?if_exists/]
    [#assign YearMap={'0':'一','1':'二','2':'三'}/]
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
              <td colspan="5">第${(YearMap[schoolYear_index?string])!}学年</td>
            </tr>
            <tr align="center">
              <td colspan="5" >(${(firstHalf[0].semester.beginOn?string("yyyy.MM"))!}--${(firstHalf[0].semester.endOn?string("yyyy.MM"))!})</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >课程</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
              <td colspan="2" >${(firstHalf[0].semester.name)!}学期</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">成绩</td>
              <td  style="white-space: nowrap; width:${width}">绩点</td>
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
              <td colspan="5" >第${(YearMap[schoolYear_index?string])!}学年</td>
            </tr>
            <tr align="center">
              <td colspan="5"  style="font-size:${fontSize+2}pt">以下空白</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >课程</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
              <td colspan="2" >${(firstHalf[0].semester.name)!}学期</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">成绩</td>
              <td  style="white-space: nowrap; width:${width}">绩点</td>
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
              <td colspan="5">第${(YearMap[schoolYear_index?string])!}学年</td>
            </tr>
            <tr align="center">
              <td colspan="5" >(${(secondHalf[0].semester.beginOn?string("yyyy.MM"))!}--${(secondHalf[0].semester.endOn?string("yyyy.MM"))!})</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >课程</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
              <td colspan="2" >${(secondHalf[0].semester.name)!}学期</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">成绩</td>
              <td  style="white-space: nowrap; width:${width}">绩点</td>
            </tr>
            [#list 0..secondRow - 1 as rowIndex]
              <tr>
                <td style="text-align: left">${(secondHalf[rowIndex].course.name)!}</td>
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
              <td colspan="5"  style="font-size:${fontSize+2}pt">以下空白</td>
            </tr>
            <tr align="center">
              <td rowspan="2" >课程</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
              <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
              <td colspan="2" >${(secondHalf[0].semester.name)!}学期</td>
            </tr>
            <tr align="center">
              <td  style="white-space: nowrap; width:${width}">成绩</td>
              <td  style="white-space: nowrap; width:${width}">绩点</td>
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
                <td colspan="5" style="font-size:${fontSize+2}pt">以下空白</td>
              </tr>
              <tr align="center">
                <td rowspan="2" >课程</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
                <td colspan="2" >${(secondHalf[0].semester.name)!}学期</td>
              </tr>
              <tr align="center">
                <td  style="white-space: nowrap; width:${width}">成绩</td>
                <td  style="white-space: nowrap; width:${width}">绩点</td>
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
                <td colspan="5"  style="font-size:${fontSize+2}pt">以下空白</td>
              </tr>
              <tr align="center">
                <td rowspan="2" >课程</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">学时</td>
                <td rowspan="2"  style="white-space: nowrap; width:${width}">学分</td>
                <td colspan="2" >${(secondHalf[0].semester.name)!}学期</td>
              </tr>
              <tr align="center">
                <td  style="white-space: nowrap; width:${width}">成绩</td>
                <td  style="white-space: nowrap; width:${width}">绩点</td>
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
      <td colspan="2"><b>总平均学分绩点</b></td>
      <td colspan="4">${(gpas.get(std).gpa)!}</td>
    </tr>
  </table>
  <table style="font-size:${fontSize-2}pt;margin: auto" class="listTable">
    <tr align="center" style="border-top: none">
      <td style="border: none">成绩</td>
      [#list 0..4 as i ]
        <td style="border: none">百分制</td>
        <td style="border: none">等级制</td>
        <td style="border: none">绩点</td>
      [/#list]
    </tr>
    <tr align="center">
      <td style="border-right: none;border-left: none;"></td>
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
      <td style="border-right: none;border-left: none;"></td>
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
      <td style="border-right: none;border-left: none;">60分以下</td>
      <td style="border-right: none;border-left: none;">F</td>
      <td style="border-right: none;border-left: none;">0</td>
    </tr>
  </table>

[/#list]
[@b.foot/]
