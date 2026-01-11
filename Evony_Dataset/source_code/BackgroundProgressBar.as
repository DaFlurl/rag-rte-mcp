// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BackgroundProgressBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.controls.ProgressBar;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
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

    public class BackgroundProgressBar extends Canvas 
    {

        private var _1131509414progressBar:ProgressBar;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":260,
                    "height":30,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ProgressBar,
                        "id":"progressBar",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mode":"manual",
                                "labelPlacement":"center",
                                "width":250
                            });
                        }
                    })]
                });
            }
        });

        public function BackgroundProgressBar()
        {
            mx_internal::_document = this;
            this.width = 260;
            this.height = 30;
        }

        [Bindable(event="propertyChange")]
        public function get progressBar():ProgressBar
        {
            return (this._1131509414progressBar);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function set progressBar(_arg_1:ProgressBar):void
        {
            var _local_2:Object = this._1131509414progressBar;
            if (_local_2 !== _arg_1)
            {
                this._1131509414progressBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "progressBar", _local_2, _arg_1));
            };
        }

        public function updateProgress(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            var _local_4:Number = (_arg_2 / _arg_3);
            var _local_5:Number = (_local_4 * 100);
            var _local_6:int = _arg_1.lastIndexOf("/");
            if (_local_6 < 0)
            {
                _local_6 = -1;
            };
            var _local_7:String = _arg_1.substr((_local_6 + 1));
            this.alpha = (1 - _local_4);
            if (int(_local_5) == 100)
            {
                this.visible = false;
            }
            else
            {
                this.visible = true;
            };
            progressBar.label = (((("Loading " + _local_7) + " ") + int(_local_5).toString()) + "%");
            progressBar.setProgress(_local_5, 100);
        }


    }
}//package view.ui

