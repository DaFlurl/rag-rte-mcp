// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.HorizontalList

package mx.controls
{
    import mx.controls.listClasses.TileBase;
    import mx.core.ScrollPolicy;
    import mx.controls.listClasses.TileBaseDirection;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HorizontalList extends TileBase 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function HorizontalList()
        {
            _horizontalScrollPolicy = ScrollPolicy.AUTO;
            _verticalScrollPolicy = ScrollPolicy.OFF;
            direction = TileBaseDirection.VERTICAL;
            maxRows = 1;
            defaultRowCount = 1;
        }

    }
}//package mx.controls

