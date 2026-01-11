// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.ViewMemberBtn_inlineComponent0

package autoevony.gui.info.Alliance
{
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Spacer;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import autoevony.gui.MainScreen;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class ViewMemberBtn_inlineComponent0 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Spacer,
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":3});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ViewMemberBtn_inlineComponent0_Button1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"View",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });

        public function ViewMemberBtn_inlineComponent0()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalGap = 0;
                this.verticalGap = 0;
            };
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function ___ViewMemberBtn_inlineComponent0_Button1_click(_arg_1:MouseEvent):void
        {
            MainScreen.getInstance()._accountInfo.allianceInfo.members.showMembersMsg(data);
        }


    }
}//package autoevony.gui.info.Alliance

