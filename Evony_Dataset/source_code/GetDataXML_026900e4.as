// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.GetDataXML

package com.evony.eum
{
    import flash.utils.Dictionary;
    import flash.xml.XMLDocument;

    public class GetDataXML 
    {

        public static var instance:GetDataXML = new (GetDataXML)();

        private var xmlDic:Dictionary = new Dictionary();

        public function GetDataXML()
        {
            var _local_1:GetDataXML_XMLBuilding = new GetDataXML_XMLBuilding();
            var _local_2:GetDataXML_XMLCastleLogo = new GetDataXML_XMLCastleLogo();
            var _local_3:GetDataXML_XMLFort = new GetDataXML_XMLFort();
            var _local_4:GetDataXML_XMLItem = new GetDataXML_XMLItem();
            var _local_5:GetDataXML_XMLPlayerLogo = new GetDataXML_XMLPlayerLogo();
            var _local_6:GetDataXML_XMLTech = new GetDataXML_XMLTech();
            var _local_7:GetDataXML_XMLTroop = new GetDataXML_XMLTroop();
            var _local_8:GetDataXML_XMLEquipTech = new GetDataXML_XMLEquipTech();
            this.xmlDic["XMLBuilding"] = new XMLDocument(_local_1.readUTFBytes(_local_1.length));
            this.xmlDic["XMLCastleLogo"] = new XMLDocument(_local_2.readUTFBytes(_local_2.length));
            this.xmlDic["XMLFort"] = new XMLDocument(_local_3.readUTFBytes(_local_3.length));
            this.xmlDic["XMLItem"] = new XMLDocument(_local_4.readUTFBytes(_local_4.length));
            this.xmlDic["XMLPlayerLogo"] = new XMLDocument(_local_5.readUTFBytes(_local_5.length));
            this.xmlDic["XMLTech"] = new XMLDocument(_local_6.readUTFBytes(_local_6.length));
            this.xmlDic["XMLTroop"] = new XMLDocument(_local_7.readUTFBytes(_local_7.length));
            this.xmlDic["XMLEquipTech"] = new XMLDocument(_local_8.readUTFBytes(_local_8.length));
        }

        public static function getInstance():void
        {
            if (!instance)
            {
                instance = new (GetDataXML)();
            };
        }


        public function getXMLDoc(_arg_1:String):XMLDocument
        {
            switch (_arg_1)
            {
                case "BuildingEumDefine":
                    return (this.xmlDic["XMLBuilding"]);
                case "CityLogoEumDefine":
                    return (this.xmlDic["XMLCastleLogo"]);
                case "FortificationEumDefine":
                    return (this.xmlDic["XMLFort"]);
                case "ItemEumDefine":
                    return (this.xmlDic["XMLItem"]);
                case "LogoEumDefine":
                    return (this.xmlDic["XMLPlayerLogo"]);
                case "TechEumDefine":
                    return (this.xmlDic["XMLTech"]);
                case "TroopEumDefine":
                    return (this.xmlDic["XMLTroop"]);
                case "EquipTechEumDefine":
                    return (this.xmlDic["XMLEquipTech"]);
            };
            return (new XMLDocument());
        }


    }
}//package com.evony.eum

