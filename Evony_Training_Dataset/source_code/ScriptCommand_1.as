package autoevony.scripts
{
   public class ScriptCommand
   {
      public var params:Array;
      
      public var scriptCmd:ScriptCmd;
      
      public function ScriptCommand(param1:ScriptCmd, param2:Array)
      {
         super();
         this.scriptCmd = param1;
         this.params = param2;
      }
   }
}

