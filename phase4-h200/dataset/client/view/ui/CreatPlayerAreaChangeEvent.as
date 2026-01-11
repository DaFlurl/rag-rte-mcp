// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CreatPlayerAreaChangeEvent

package view.ui
{
    import flash.events.MouseEvent;

    public class CreatPlayerAreaChangeEvent extends MouseEvent 
    {

        public var creatPlayerMap:CreatPlayerMap;
        public var areaName:String;
        public var areaId:int;

        public function CreatPlayerAreaChangeEvent(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:CreatPlayerMap, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this.areaName = _arg_2;
            this.areaId = _arg_3;
            this.creatPlayerMap = _arg_4;
        }

    }
}//package view.ui

