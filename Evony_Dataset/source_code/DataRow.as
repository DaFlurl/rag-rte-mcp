package autoevony.common
{
   import flash.events.EventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   
   public class DataRow extends EventDispatcher
   {
      private var _3059381col5:Object;
      
      private var _3059382col6:Object;
      
      private var _3059383col7:Object;
      
      private var _3059384col8:Object;
      
      private var _3059385col9:Object;
      
      private var _94840735col10:Object;
      
      private var _204859874bgColor:Object;
      
      private var _102727412label:Object = "";
      
      private var _3059376col0:Object;
      
      private var _3059377col1:Object;
      
      private var _3059378col2:Object;
      
      private var _3059379col3:Object;
      
      private var _3059380col4:Object;
      
      public function DataRow()
      {
         super();
      }
      
      public static function copyRowArray(param1:ArrayCollection, param2:ArrayCollection) : void
      {
         var _loc3_:int = param2.length - 1;
         while(_loc3_ >= param1.length)
         {
            param2.removeItemAt(_loc3_);
            _loc3_--;
         }
         _loc3_ = 0;
         while(_loc3_ < Math.min(param2.length,param1.length))
         {
            if(!param2[_loc3_].same(param1[_loc3_]))
            {
               param2.setItemAt(param1[_loc3_],_loc3_);
            }
            _loc3_++;
         }
         _loc3_ = param2.length;
         while(_loc3_ < param1.length)
         {
            param2.addItem(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgColor() : Object
      {
         return this._204859874bgColor;
      }
      
      [Bindable(event="propertyChange")]
      public function get col10() : Object
      {
         return this._94840735col10;
      }
      
      [Bindable(event="propertyChange")]
      public function get col0() : Object
      {
         return this._3059376col0;
      }
      
      [Bindable(event="propertyChange")]
      public function get col1() : Object
      {
         return this._3059377col1;
      }
      
      [Bindable(event="propertyChange")]
      public function get col2() : Object
      {
         return this._3059378col2;
      }
      
      [Bindable(event="propertyChange")]
      public function get col4() : Object
      {
         return this._3059380col4;
      }
      
      [Bindable(event="propertyChange")]
      public function get col5() : Object
      {
         return this._3059381col5;
      }
      
      [Bindable(event="propertyChange")]
      public function get col6() : Object
      {
         return this._3059382col6;
      }
      
      [Bindable(event="propertyChange")]
      public function get col7() : Object
      {
         return this._3059383col7;
      }
      
      [Bindable(event="propertyChange")]
      public function get col8() : Object
      {
         return this._3059384col8;
      }
      
      [Bindable(event="propertyChange")]
      public function get col9() : Object
      {
         return this._3059385col9;
      }
      
      [Bindable(event="propertyChange")]
      public function get col3() : Object
      {
         return this._3059379col3;
      }
      
      public function set bgColor(param1:Object) : void
      {
         var _loc2_:Object = this._204859874bgColor;
         if(_loc2_ !== param1)
         {
            this._204859874bgColor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgColor",_loc2_,param1));
         }
      }
      
      public function set col10(param1:Object) : void
      {
         var _loc2_:Object = this._94840735col10;
         if(_loc2_ !== param1)
         {
            this._94840735col10 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col10",_loc2_,param1));
         }
      }
      
      public function set col0(param1:Object) : void
      {
         var _loc2_:Object = this._3059376col0;
         if(_loc2_ !== param1)
         {
            this._3059376col0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col0",_loc2_,param1));
         }
      }
      
      public function set col1(param1:Object) : void
      {
         var _loc2_:Object = this._3059377col1;
         if(_loc2_ !== param1)
         {
            this._3059377col1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col1",_loc2_,param1));
         }
      }
      
      public function set col5(param1:Object) : void
      {
         var _loc2_:Object = this._3059381col5;
         if(_loc2_ !== param1)
         {
            this._3059381col5 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col5",_loc2_,param1));
         }
      }
      
      public function set col2(param1:Object) : void
      {
         var _loc2_:Object = this._3059378col2;
         if(_loc2_ !== param1)
         {
            this._3059378col2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col2",_loc2_,param1));
         }
      }
      
      public function set col6(param1:Object) : void
      {
         var _loc2_:Object = this._3059382col6;
         if(_loc2_ !== param1)
         {
            this._3059382col6 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col6",_loc2_,param1));
         }
      }
      
      private function same(param1:DataRow) : Boolean
      {
         if(this.col0 != param1.col0)
         {
            return false;
         }
         if(this.col1 != param1.col1)
         {
            return false;
         }
         if(this.col2 != param1.col2)
         {
            return false;
         }
         if(this.col3 != param1.col3)
         {
            return false;
         }
         if(this.col4 != param1.col4)
         {
            return false;
         }
         if(this.col5 != param1.col5)
         {
            return false;
         }
         if(this.col6 != param1.col6)
         {
            return false;
         }
         if(this.col7 != param1.col7)
         {
            return false;
         }
         if(this.col8 != param1.col8)
         {
            return false;
         }
         if(this.col9 != param1.col9)
         {
            return false;
         }
         if(this.col10 != param1.col10)
         {
            return false;
         }
         if(this.label != param1.label)
         {
            return false;
         }
         if(this.bgColor != param1.bgColor)
         {
            return false;
         }
         return true;
      }
      
      public function set col7(param1:Object) : void
      {
         var _loc2_:Object = this._3059383col7;
         if(_loc2_ !== param1)
         {
            this._3059383col7 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col7",_loc2_,param1));
         }
      }
      
      public function set col4(param1:Object) : void
      {
         var _loc2_:Object = this._3059380col4;
         if(_loc2_ !== param1)
         {
            this._3059380col4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col4",_loc2_,param1));
         }
      }
      
      public function set col8(param1:Object) : void
      {
         var _loc2_:Object = this._3059384col8;
         if(_loc2_ !== param1)
         {
            this._3059384col8 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col8",_loc2_,param1));
         }
      }
      
      public function set col9(param1:Object) : void
      {
         var _loc2_:Object = this._3059385col9;
         if(_loc2_ !== param1)
         {
            this._3059385col9 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col9",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label() : Object
      {
         return this._102727412label;
      }
      
      public function set col3(param1:Object) : void
      {
         var _loc2_:Object = this._3059379col3;
         if(_loc2_ !== param1)
         {
            this._3059379col3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"col3",_loc2_,param1));
         }
      }
      
      public function set label(param1:Object) : void
      {
         var _loc2_:Object = this._102727412label;
         if(_loc2_ !== param1)
         {
            this._102727412label = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label",_loc2_,param1));
         }
      }
   }
}

