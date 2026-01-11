// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.gift.packageStatusLabel

package view.module.gift
{
    import mx.controls.Label;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.common.constants.ObjConstants;
    import com.evony.Lang;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class packageStatusLabel extends Label 
    {

        public function packageStatusLabel()
        {
            super();
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.color = 5312268;
            };
        }

        override public function initialize():void
        {
            super.initialize();
        }

        public function set status(_arg_1:int):void
        {
            var _local_2:String;
            this.enabled = true;
            switch (_arg_1)
            {
                case ObjConstants.PACKAGE_STATUS_SERIAL:
                    _local_2 = "Not Active Yet";
                    this.setStyle("textDecoration", "none");
                    break;
                case ObjConstants.PACKAGE_STATUS_AVAIBLE:
                    _local_2 = Lang.msg("立即领取");
                    break;
                case ObjConstants.PACKAGE_STATUS_NOT_MET:
                    _local_2 = Lang.msg("条件不足");
                    this.setStyle("textDecoration", "none");
                    break;
                case ObjConstants.PACKAGE_STATUS_HAD_GOT:
                    _local_2 = Lang.msg("已领取");
                    this.setStyle("textDecoration", "none");
                    break;
                case 0:
                    _local_2 = Lang.msg("未领取");
                    break;
            };
            this.text = _local_2;
        }


    }
}//package view.module.gift

