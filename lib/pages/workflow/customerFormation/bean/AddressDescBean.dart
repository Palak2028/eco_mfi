


import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/address/beans/CountryDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';


class AddressDescBean {

        CountryDropDownBean cuntryBean;
        StateDropDownList stateDropDownBean;
        DistrictDropDownList districtDropDownBean;
        SubDistrictDropDownList subDistrictDropDownBean;


        AddressDescBean({this.cuntryBean,
          this.stateDropDownBean,
          this.districtDropDownBean,
          this.subDistrictDropDownBean,
        });


        /*factory AddressDescBean.fromMap(Map<String, dynamic> map) {
          return AddressDescBean(
            mgrpcd: map[TablesColumnFile.mgrpcd] as int,
            musrcode: map[TablesColumnFile.musrcode] as String,
            menuId: map[TablesColumnFile.menuId] as int,
            mchartid: map[TablesColumnFile.mchartid] as int,
            create: map[TablesColumnFile.create] as int,
            modify: map[TablesColumnFile.modify] as int,
            browse: map[TablesColumnFile.browse] as int,
            authority: map[TablesColumnFile.authority] as int,
            delete: map[TablesColumnFile.delete] as int,

          );
        }

        factory AddressDescBean.fromJoinMap(Map<String, dynamic> map) {
          return AddressDescBean(
            mgrpcd: map[TablesColumnFile.mgrpcd] as int,
            musrcode: map[TablesColumnFile.musrcode] as String,
            menuId: map[TablesColumnFile.menuId] as int,
            mchartid: map[TablesColumnFile.mchartid] as int,
            create: map[TablesColumnFile.create] as int,
            modify: map[TablesColumnFile.modify] as int,
            browse: map[TablesColumnFile.browse] as int,
            authority: map[TablesColumnFile.authority] as int,
            delete: map[TablesColumnFile.delete] as int,
            menuid: map[TablesColumnFile.menuid] as int,
            menuDesc: map[TablesColumnFile.menuDesc] as String,
            menutype: map[TablesColumnFile.menutype] as String,
            parenttype: map[TablesColumnFile.parenttype] as String,
            murl: map[TablesColumnFile.murl] as String,


          );
        }*/
      }