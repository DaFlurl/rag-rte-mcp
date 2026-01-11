package autoevony.gui
{
   import autoevony.common.Utils;
   import flash.display.Sprite;
   import mx.controls.DataGrid;
   
   public class RowColorDataGrid extends DataGrid
   {
      public function RowColorDataGrid()
      {
         super();
      }
      
      override protected function drawRowBackground(param1:Sprite, param2:int, param3:Number, param4:Number, param5:uint, param6:int) : void
      {
         var _loc7_:* = null;
         if(dataProvider != null)
         {
            if(param6 < dataProvider.length)
            {
               _loc7_ = dataProvider[param6];
            }
            if(_loc7_ && _loc7_.bgColor != null && Utils.hasValue(_loc7_.bgColor))
            {
               param5 = uint(_loc7_.bgColor);
            }
         }
         super.drawRowBackground(param1,param2,param3,param4,param5,param6);
      }
   }
}

