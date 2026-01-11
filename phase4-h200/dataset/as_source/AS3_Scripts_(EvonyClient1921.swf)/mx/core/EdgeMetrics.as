// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.EdgeMetrics

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EdgeMetrics 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const EMPTY:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0);

        public var top:Number;
        public var left:Number;
        public var bottom:Number;
        public var right:Number;

        public function EdgeMetrics(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0)
        {
            this.left = _arg_1;
            this.top = _arg_2;
            this.right = _arg_3;
            this.bottom = _arg_4;
        }

        public function clone():EdgeMetrics
        {
            return (new EdgeMetrics(left, top, right, bottom));
        }


    }
}//package mx.core

