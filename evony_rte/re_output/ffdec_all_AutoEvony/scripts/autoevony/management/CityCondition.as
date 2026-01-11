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
      
      public function CityCondition(param1:Boolean, param2:int, param3:int, param4:int = 1)
      {
         super();
         this.isBuilding = param1;
         this.typeId = param2;
         this.level = param3;
         this.count = param4;
         this.orgLevel = param3;
         this.orgCount = param4;
         if(param1)
         {
            this.name = BuildingType.toString(param2);
         }
         else
         {
            this.name = TechType.toString(param2);
         }
      }
      
      public function toString() : String
      {
         if(this.isBuilding)
         {
            return "building " + BuildingType.toString(this.typeId) + ":" + this.level + "/" + this.count;
         }
         return "tech " + TechType.toString(this.typeId) + ":" + this.level;
      }
      
      public function _dj829(param1:CityCondition) : Boolean
      {
         return this.isBuilding == param1.isBuilding && this.typeId == param1.typeId && this.level <= param1.level && this.count <= param1.count;
      }
   }
}

