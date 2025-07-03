// add depth and height

final static int sampleCount = 14;

Table table;
float[] ratio;
float[] x;
float[] y;
String[] IDs;
int c = 0;

Table outTable;

void setup() {

  table = loadTable("faceMetrics.csv", "header");
  ratio = new float[sampleCount];
  IDs  = new String[sampleCount];
  x = new float[sampleCount];
  y = new float[sampleCount];

  outTable = new Table();
  outTable.addColumn("sample1");
  outTable.addColumn("sample2");
  outTable.addColumn("ratio");
  outTable.addColumn("x-z");
  outTable.addColumn("y");
  

  for (TableRow row : table.rows()) {
    IDs[c] = row.getString("sample");
    ratio[c] = row.getFloat("heightRatio");
    x[c] = row.getFloat("x-z");
    y[c] = row.getFloat("yPct");
    println(IDs[c], ratio[c]);
    c++;
  }

  for (int i = 0; i<IDs.length/2; i++) {
    for (int j = IDs.length/2-1; j<IDs.length-2; j++) {
        println(i,j);
        TableRow newRow = outTable.addRow();
        newRow.setString("sample1", IDs[i]);
        newRow.setString("sample2", IDs[j]);
        newRow.setFloat("ratio", (ratio[i]+ratio[j])/2);
        newRow.setFloat("x-z", (x[i]+x[j])/2);
        newRow.setFloat("y", (y[i]+y[j])/2);

    }
  }
  outTable.sort("ratio");

  saveTable(outTable, "faceRatios.csv");
  exit();
}
