// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.BuildingLevelData

package com.evony.eum
{
    public class BuildingLevelData 
    {

        public var level:int;
        public var stone:int;
        public var wood:int;
        public var workPeople:int;
        public var time:int;
        public var iron:int;
        public var produce:int;
        public var limit:int;
        public var buildPeople:int;
        public var food:int;

        public function BuildingLevelData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int)
        {
            this.level = _arg_1;
            this.workPeople = _arg_2;
            this.limit = _arg_3;
            this.produce = _arg_4;
            this.food = _arg_5;
            this.wood = _arg_6;
            this.stone = _arg_7;
            this.iron = _arg_8;
            this.time = _arg_9;
            this.buildPeople = _arg_10;
        }

    }
}//package com.evony.eum

