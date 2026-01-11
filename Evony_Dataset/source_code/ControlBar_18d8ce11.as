// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.ControlBar

package mx.containers
{
    import mx.core.ScrollPolicy;
    import mx.core.Container;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ControlBar extends Box 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function ControlBar()
        {
            direction = BoxDirection.HORIZONTAL;
        }

        override public function set verticalScrollPolicy(_arg_1:String):void
        {
        }

        override public function set horizontalScrollPolicy(_arg_1:String):void
        {
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (contentPane)
            {
                contentPane.opaqueBackground = null;
            };
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            if (_arg_1 != super.enabled)
            {
                super.enabled = _arg_1;
                alpha = ((_arg_1) ? 1 : 0.4);
            };
        }

        override public function get horizontalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        override public function invalidateSize():void
        {
            super.invalidateSize();
            if (parent)
            {
                Container(parent).invalidateViewMetricsAndPadding();
            };
        }

        override public function get verticalScrollPolicy():String
        {
            return (ScrollPolicy.OFF);
        }

        override public function set includeInLayout(_arg_1:Boolean):void
        {
            var _local_2:Container;
            if (includeInLayout != _arg_1)
            {
                super.includeInLayout = _arg_1;
                _local_2 = (parent as Container);
                if (_local_2)
                {
                    _local_2.invalidateViewMetricsAndPadding();
                };
            };
        }


    }
}//package mx.containers

