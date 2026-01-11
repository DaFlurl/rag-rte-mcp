// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.CastleFlag

package view.castle.world
{
    import mx.core.UIComponent;
    import flash.text.TextField;
    import mx.controls.Image;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import com.evony.common.beans.MapCastleBean;

    public class CastleFlag extends UIComponent 
    {

        private var txt:TextField;
        private var img:Image;
        private var castleFlagMc:CastleFlagMc;

        public function CastleFlag()
        {
            castleFlagMc = new CastleFlagMc();
            this.addChild(castleFlagMc);
            txt = new TextField();
            txt.selectable = false;
            txt.autoSize = TextFieldAutoSize.CENTER;
            var _local_1:TextFormat = new TextFormat();
            _local_1.font = "Tahoma";
            _local_1.bold = true;
            _local_1.color = 0xFFFFFF;
            txt.setTextFormat(_local_1);
            txt.x = 15;
            txt.y = -2;
            this.addChild(txt);
            this.x = 25;
            this.y = 0;
        }

        public function destroy():void
        {
            if (this.castleFlagMc != null)
            {
                this.castleFlagMc.destroy();
            };
        }

        public function setMapCastleBean(_arg_1:MapCastleBean, _arg_2:int=0, _arg_3:Boolean=false):void
        {
            this.castleFlagMc.setMapCastleBean(_arg_1, _arg_3);
            if (_arg_1.npc)
            {
                this.txt.visible = false;
            }
            else
            {
                this.txt.visible = true;
                this.txt.text = _arg_1.flag;
            };
        }

        public function getCastleFlagMc():CastleFlagMc
        {
            return (this.castleFlagMc);
        }


    }
}//package view.castle.world

