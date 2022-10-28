package dto;

public class ReserveDto {
	private int id, bang_id, inwon, charcoal, bbq, total, state;
	private String inday, outday, userid, writeday, bang;
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getBang() {
		return bang;
	}
	public void setBang(String bang) {
		this.bang = bang;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBang_id() {
		return bang_id;
	}
	public void setBang_id(int bang_id) {
		this.bang_id = bang_id;
	}
	public int getInwon() {
		return inwon;
	}
	public void setInwon(int inwon) {
		this.inwon = inwon;
	}
	public int getCharcoal() {
		return charcoal;
	}
	public void setCharcoal(int charcoal) {
		this.charcoal = charcoal;
	}
	public int getBbq() {
		return bbq;
	}
	public void setBbq(int bbq) {
		this.bbq = bbq;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getInday() {
		return inday;
	}
	public void setInday(String inday) {
		this.inday = inday;
	}
	public String getOutday() {
		return outday;
	}
	public void setOutday(String outday) {
		this.outday = outday;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
}
