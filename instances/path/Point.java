
public class Point {

	protected int x;
	protected int y;
	public Point() {
		x=0;
		y=0;
	}
	public Point(int ix,int iy) {
		x=ix;
		y=iy;
	}
	public Point(Integer ix,Integer iy) {
		x=ix;
		y=iy;
	}
	public int getX() {
		return(x);
	}
	public int getY() {
		return(y);
	}
	public String toString() {
		return(String.valueOf(x)+","+String.valueOf(y));
	}
}
