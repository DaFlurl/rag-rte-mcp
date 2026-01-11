// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.StowLists_inlineComponent6

package view.module.trainningField
{
    import mx.controls.Label;
    import mx.styles.CSSStyleDeclaration;
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

    public class StowLists_inlineComponent6 extends Label 
    {

        private var _88844982outerDocument:StowLists;

        public function StowLists_inlineComponent6()
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

        [Bindable(event="propertyChange")]
        public function get outerDocument():StowLists
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            super.initialize();
        }

        public function set outerDocument(_arg_1:StowLists):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.module.trainningField

