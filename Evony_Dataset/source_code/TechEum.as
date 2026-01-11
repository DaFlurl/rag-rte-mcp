// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.TechEum

package com.evony.eum
{
    public class TechEum 
    {

        public var wikiDesc:String;
        public var name:String;
        private var levelData:Array = new Array();
        public var desc:String;
        public var typeId:int;
        private var upLevelDescs:Array = new Array();
        public var upLevelDesc:String;


        public function addUpLevelDesc(_arg_1:UpLevelDesc):void
        {
            this.upLevelDescs[_arg_1.level] = _arg_1;
        }

        public function getUpLevelDesc(_arg_1:int):UpLevelDesc
        {
            return (this.upLevelDescs[_arg_1] as UpLevelDesc);
        }

        public function addLevelData(_arg_1:TechLevelData):void
        {
            this.levelData[_arg_1.level] = _arg_1;
        }

        public function getLevelData(_arg_1:int):TechLevelData
        {
            return (this.levelData[_arg_1] as TechLevelData);
        }


    }
}//package com.evony.eum

