// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.gridClasses.GridRowInfo

package mx.containers.gridClasses
{
    import mx.core.UIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GridRowInfo 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var y:Number;
        public var preferred:Number;
        public var max:Number;
        public var height:Number;
        public var flex:Number;
        public var min:Number;

        public function GridRowInfo()
        {
            min = 0;
            preferred = 0;
            max = UIComponent.DEFAULT_MAX_HEIGHT;
            flex = 0;
        }

    }
}//package mx.containers.gridClasses

