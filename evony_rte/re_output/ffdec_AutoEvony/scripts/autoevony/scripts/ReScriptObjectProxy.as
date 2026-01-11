package autoevony.scripts
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public dynamic class ReScriptObjectProxy extends Proxy
   {
      
      private var obj:Object = null;
      
      private var tempObj:Object = null;
      
      public function ReScriptObjectProxy(param1:Object = null)
      {
         super();
         this.obj = param1 == null ? new Object() : param1;
         this.tempObj = new Object();
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         this.obj[param1].apply(this.obj,rest);
      }
      
      public function clearTempProperties() : void
      {
         this.tempObj = new Object();
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(this.obj[param1] != undefined)
         {
            this.obj[param1] = param2;
         }
         else
         {
            this.tempObj[param1] = param2;
         }
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         if(this.obj[param1] != undefined)
         {
            return this.obj[param1];
         }
         if(this.tempObj != null && this.tempObj[param1] != undefined)
         {
            return this.tempObj[param1];
         }
         return undefined;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         if(this.obj[param1] != undefined)
         {
            return true;
         }
         if(this.tempObj != null && this.tempObj[param1] != undefined)
         {
            return true;
         }
         return false;
      }
   }
}

