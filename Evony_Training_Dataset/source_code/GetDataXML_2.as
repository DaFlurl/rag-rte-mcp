package com.evony.eum
{
   import flash.utils.Dictionary;
   import flash.xml.XMLDocument;
   
   public class GetDataXML
   {
      public static var instance:GetDataXML = new GetDataXML();
      
      private var xmlDic:Dictionary = new Dictionary();
      
      public function GetDataXML()
      {
         super();
         var _loc1_:GetDataXML_XMLBuilding = new GetDataXML_XMLBuilding();
         var _loc2_:GetDataXML_XMLCastleLogo = new GetDataXML_XMLCastleLogo();
         var _loc3_:GetDataXML_XMLFort = new GetDataXML_XMLFort();
         var _loc4_:GetDataXML_XMLItem = new GetDataXML_XMLItem();
         var _loc5_:GetDataXML_XMLPlayerLogo = new GetDataXML_XMLPlayerLogo();
         var _loc6_:GetDataXML_XMLTech = new GetDataXML_XMLTech();
         var _loc7_:GetDataXML_XMLTroop = new GetDataXML_XMLTroop();
         var _loc8_:GetDataXML_XMLEquipTech = new GetDataXML_XMLEquipTech();
         this.xmlDic["XMLBuilding"] = new XMLDocument(_loc1_.readUTFBytes(_loc1_.length));
         this.xmlDic["XMLCastleLogo"] = new XMLDocument(_loc2_.readUTFBytes(_loc2_.length));
         this.xmlDic["XMLFort"] = new XMLDocument(_loc3_.readUTFBytes(_loc3_.length));
         this.xmlDic["XMLItem"] = new XMLDocument(_loc4_.readUTFBytes(_loc4_.length));
         this.xmlDic["XMLPlayerLogo"] = new XMLDocument(_loc5_.readUTFBytes(_loc5_.length));
         this.xmlDic["XMLTech"] = new XMLDocument(_loc6_.readUTFBytes(_loc6_.length));
         this.xmlDic["XMLTroop"] = new XMLDocument(_loc7_.readUTFBytes(_loc7_.length));
         this.xmlDic["XMLEquipTech"] = new XMLDocument(_loc8_.readUTFBytes(_loc8_.length));
      }
      
      public static function getInstance() : void
      {
         if(!instance)
         {
            instance = new GetDataXML();
         }
      }
      
      public function getXMLDoc(param1:String) : XMLDocument
      {
         switch(param1)
         {
            case "BuildingEumDefine":
               return this.xmlDic["XMLBuilding"];
            case "CityLogoEumDefine":
               return this.xmlDic["XMLCastleLogo"];
            case "FortificationEumDefine":
               return this.xmlDic["XMLFort"];
            case "ItemEumDefine":
               return this.xmlDic["XMLItem"];
            case "LogoEumDefine":
               return this.xmlDic["XMLPlayerLogo"];
            case "TechEumDefine":
               return this.xmlDic["XMLTech"];
            case "TroopEumDefine":
               return this.xmlDic["XMLTroop"];
            case "EquipTechEumDefine":
               return this.xmlDic["XMLEquipTech"];
            default:
               return new XMLDocument();
         }
      }
   }
}

