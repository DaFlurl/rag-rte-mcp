// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.DgRendererLabel

package view.module.rank
{
    import mx.controls.Label;
    import com.evony.factory.PlayerInfoTypeManager;

    public class DgRendererLabel extends Label 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        public function set lText(_arg_1:String):void
        {
            this.text = _arg_1;
        }

        public function set title(_arg_1:int):void
        {
            this.text = PlayerInfoTypeManager.getTitle(_arg_1);
        }

        public function set lStyle(_arg_1:int):void
        {
            if (((_arg_1) && (_arg_1 == 1)))
            {
                this.styleName = "commonWorningColorNotRead";
            };
        }


    }
}//package view.module.rank

