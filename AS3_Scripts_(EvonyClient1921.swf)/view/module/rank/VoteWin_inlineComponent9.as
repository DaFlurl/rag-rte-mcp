// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.VoteWin_inlineComponent9

package view.module.rank
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

    public class VoteWin_inlineComponent9 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "events":{"click":"___VoteWin_inlineComponent9_CheckOutButton1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Vote",
                                "height":22,
                                "width":70
                            });
                        }
                    })]});
            }
        });
        private var _88844982outerDocument:VoteWin;

        public function VoteWin_inlineComponent9()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.top = "1";
                this.bottom = "1";
                this.horizontalAlign = "center";
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ___VoteWin_inlineComponent9_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            parentDocument.vote(data);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():VoteWin
        {
            return (this._88844982outerDocument);
        }

        public function set outerDocument(_arg_1:VoteWin):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.module.rank

