// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.friendList.DisappearHeroList_inlineComponent2

package view.module.friendList
{
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import view.module.office.CheckOutButton;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
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

    public class DisappearHeroList_inlineComponent2 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "events":{"click":"___DisappearHeroList_inlineComponent2_CheckOutButton1_click"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"label":"restore"});
                        }
                    })]});
            }
        });
        private var _88844982outerDocument:DisappearHeroList;

        public function DisappearHeroList_inlineComponent2()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ___DisappearHeroList_inlineComponent2_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            parentDocument.restoreHero(data);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():DisappearHeroList
        {
            return (this._88844982outerDocument);
        }

        public function set outerDocument(_arg_1:DisappearHeroList):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.module.friendList

