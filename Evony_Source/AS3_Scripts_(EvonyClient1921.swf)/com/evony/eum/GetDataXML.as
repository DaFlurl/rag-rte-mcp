// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.GetDataXML

package com.evony.eum
{
    import flash.xml.XMLDocument;
    import flash.utils.Dictionary;

    public class GetDataXML 
    {

        public static var instance:GetDataXML = new (GetDataXML)();

        private var xmlDoc:XMLDocument = new XMLDocument();
        private var xmlDic:Dictionary = new Dictionary();

        public function GetDataXML()
        {
            var _local_1:Class = GetDataXML_XMLBuilding;
            var _local_2:Class = GetDataXML_XMLCastleLogo;
            var _local_3:Class = GetDataXML_XMLFort;
            var _local_4:Class = GetDataXML_XMLItem;
            var _local_5:Class = GetDataXML_XMLPlayerLogo;
            var _local_6:Class = GetDataXML_XMLTech;
            var _local_7:Class = GetDataXML_XMLTroop;
            var _local_8:Class = GetDataXML_XMLEquipTech;
            xmlDic["XMLBuilding"] = new XMLDocument(new (_local_1)());
            xmlDic["XMLCastleLogo"] = new XMLDocument(new (_local_2)());
            xmlDic["XMLFort"] = new XMLDocument(new (_local_3)());
            xmlDic["XMLItem"] = new XMLDocument(new (_local_4)());
            xmlDic["XMLPlayerLogo"] = new XMLDocument(new (_local_5)());
            xmlDic["XMLTech"] = new XMLDocument(new (_local_6)());
            xmlDic["XMLTroop"] = new XMLDocument(new (_local_7)());
            xmlDic["XMLEquipTech"] = new XMLDocument(new (_local_8)());
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
                    xmlDoc = xmlDic["XMLBuilding"];
                    break;
                case "CityLogoEumDefine":
                    xmlDoc = xmlDic["XMLCastleLogo"];
                    break;
                case "FortificationEumDefine":
                    xmlDoc = xmlDic["XMLFort"];
                    break;
                case "ItemEumDefine":
                    xmlDoc = xmlDic["XMLItem"];
                    break;
                case "LogoEumDefine":
                    xmlDoc = xmlDic["XMLPlayerLogo"];
                    break;
                case "TechEumDefine":
                    xmlDoc = xmlDic["XMLTech"];
                    break;
                case "TroopEumDefine":
                    xmlDoc = xmlDic["XMLTroop"];
                    break;
                case "EquipTechEumDefine":
                    xmlDoc = xmlDic["XMLEquipTech"];
            };
            return (xmlDoc);
        }


    }
}//package com.evony.eum

