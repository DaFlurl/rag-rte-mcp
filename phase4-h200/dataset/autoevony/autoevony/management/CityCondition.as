// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.management.CityCondition

package autoevony.management
{
    import autoevony.common.BuildingType;
    import autoevony.common.TechType;

    public class CityCondition 
    {

        public var orgLevel:int;
        public var level:int;
        public var orgCount:int;
        public var count:int;
        public var name:String;
        public var typeId:int;
        public var isBuilding:Boolean;

        public function CityCondition(_arg_1:Boolean, _arg_2:int, _arg_3:int, _arg_4:int=1)
        {
            this.isBuilding = _arg_1;
            this.typeId = _arg_2;
            this.level = _arg_3;
            this.count = _arg_4;
            this.orgLevel = _arg_3;
            this.orgCount = _arg_4;
            if (_arg_1)
            {
                this.name = BuildingType.toString(_arg_2);
            }
            else
            {
                this.name = TechType.toString(_arg_2);
            };
        }

        public function toString():String
        {
            if (this.isBuilding)
            {
                return ((((("building " + BuildingType.toString(this.typeId)) + ":") + this.level) + "/") + this.count);
            };
            return ((("tech " + TechType.toString(this.typeId)) + ":") + this.level);
        }

        public function _dj829(_arg_1:CityCondition):Boolean
        {
            return ((((this.isBuilding == _arg_1.isBuilding) && (this.typeId == _arg_1.typeId)) && (this.level <= _arg_1.level)) && (this.count <= _arg_1.count));
        }


    }
}//package autoevony.management

