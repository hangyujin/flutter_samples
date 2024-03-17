import 'dart:io';

const testCases = [
  '1_1',
  '1_2',
  '1_3',
  '2_1',
  '2_2',
  '3_1',
  '3_2',
  '4_1',
  '4_2',
  '4_3',
];
void main(List<String> arguments) {
  for (var myCase in testCases) {
    // Specify the file paths
    String inputFilePath = '${myCase}.txt';
    String outputFilePath = '${myCase}.xml';
    // Read domains from the input file
    List<String> domainList = readDomainsFromFile(inputFilePath);

    var domainXML='';

        domainList.forEach((domain) {
      domainXML+=generateXml(domain);
    });

    // Generate and write XML for each domain to the output file
    writeXmlToFile(outputFilePath, domainXML,myCase);
  }
}

List<String> readDomainsFromFile(String filePath) {
  try {
    // Read the file and split its content into a list of strings
    File file = File(filePath);
    List<String> lines = file.readAsLinesSync();

    return lines;
  } catch (e) {
    print('Error reading file: $e');
    return [];
  }
}

void writeXmlToFile(String filePath, String domainXML, String myCase) {
  try {
    // Open the file for writing
    File file = File(filePath);
    IOSink sink = file.openWrite();

    // Write XML 

     sink.write(template(myCase, domainXML));

    // Close the file
    sink.close();
    print('XML output written to $filePath');
  } catch (e) {
    print('Error writing to file: $e');
  }
}

String generateXml(String domain) {
  return '            <data android:host="$domain" />\n';
}


String template(String myCase,String domainXML) {
  return '''
  <manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="test_${myCase}"
        android:name="\${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            
            <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

            <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="https" />
${domainXML}
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility?hl=en and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
  
  
  ''';
}