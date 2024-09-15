import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/vaultProviders/premed_provider.dart';


class EngineeringTimer extends StatefulWidget {
  const EngineeringTimer({super.key});

  @override
  State<EngineeringTimer> createState() => _EngineeringTimerState();
}

class _EngineeringTimerState extends State<EngineeringTimer> {
  bool _provincialMDCAT = false;
  bool _akuTest = false;
  bool _numsTest = false;
  bool _other = false;
  String _selectedUniversity = 'Not Selected';
  String? _selectedExamType;
  DateTime? _selectedDate;
  Timer? _timer;
  String _timeLeft = '';
  late List<String> filteredUniversities;
  String _searchText = '';
  final List<String> universities = [
    "Chandka Medical College",
    "Dow Medical College",
    "Sindh Medical College",
    "Karachi Medical and Dental College",
    "Khairpur Medical College",
    "Liaquat University of Medical and Health Sciences",
    "Peoples University of Medical and Health Sciences for Women",
    "Dow International Medical College",
    "Shaheed Mohtarma Benazir Bhutto Medical College Lyari",
    "Aga Khan University Medical College",
    "Bilawal Medical College",
    "Karachi Dental College",
    "University College of Medicine and Dentistry",
    "Hamdard College of Medicine and Dentistry",
    "Jinnah Medical and Dental College",
    "Sir Syed College of Medical Sciences",
    "Ziauddin Medical College",
    "Muhammad Medical College",
    "Liaquat National Medical College",
    "Bahria University Medical and Dental College",
    "Al-Tibri Medical College",
    "Liaquat College of Medicine and Dentistry",
    "United Medical and Dental College",
    "Indus Medical College",
    "King Edward Medical College",
    "Rawalpindi Medical University",
    "Sargodha Medical College",
    "Allama Iqbal Medical College",
    "Faisalabad Medical University",
    "Quaid-e-Azam Medical College",
    "Nishtar Medical College",
    "Services Institute of Medical Sciences",
    "Army Medical College",
    "Federal Medical and Dental College",
    "Khawaja Muhammad Safdar Medical College",
    "Gujranwala Medical College",
    "Sahiwal Medical College",
    "DG Khan Medical College",
    "Sheikh Zayed Medical College",
    "Abwa Medical College",
    "Fazaia Medical College",
    "Fazaia Ruth Pfau Medical College",
    "Foundation University Medical College",
    "Islamic International Medical College",
    "Shifa College of Medicine",
    "Wah Medical College",
    "HITEC Institute of Medical Sciences",
    "Quetta Institute of Medical Sciences",
    "University Medical College",
    "University Dental College",
    "Islamabad Dental College",
    "Independent Medical College",
    "Continental Medical College",
    "Akhtar Saeed Medical College",
    "Akhtar Saeed Dental College",
    "Ameer ud Din Medical College",
    "FMH College of Medicine",
    "FMH College of Dentistry",
    "Lahore Medical College",
    "Lahore Medical and Dental College of Dentistry",
    "Pak Red Crescent Medical College",
    "Pak Red Crescent Dental College",
    "Rahbar Medical College",
    "Rahbar Dental College",
    "Rashid Latif Medical College",
    "Rashid Latif Dental College",
    "Shaikh Khalifa Bin Zayed Al Nahyan Medical College",
    "Shaikh Khalifa Bin Zayed Al Nahyan Dental College",
    "Shalamar Medical College",
    "Shalamar Dental College",
    "Sharif Medical College",
    "Sharif Dental College",
    "Central Park Medical College",
    "Avicenna Medical College",
    "Avicenna Dental College",
    "Yusra Medical and Dental College",
    "Islam Medical College",
    "Amna Inayat Medical College",
    "Azra Naheed Medical College",
    "Azra Naheed Dental College",
    "Al-Nafees Medical College",
    "Aziz Fatimah Medical College",
    "Hashmat Medical and Dental College",
    "Rawal Institute of Health Sciences",
    "Hazrat Bari Imam Sarkar Medical and Dental College",
    "M. Islam Medical and Dental College",
    "Sahara Medical College",
    "Al Aleem Medical College",
    "Ayub Medical College",
    "Khyber Medical College",
    "Saidu Medical College",
    "Gomal Medical College",
    "KMU Institute of Medical Sciences",
    "Khyber Girls Medical College",
    "Bacha Khan Medical College",
    "Bannu Medical College",
    "Swat Medical College",
    "Nowshera Medical College",
    "Northwest School of Medicine",
    "Frontier Medical College",
    "Kabir Medical College",
    "Women Medical College",
    "Peshwar Medical College",
    "Abbottabad International Medical College",
    "Jinnah Medical College",
    "Pak International Medical College",
    "Rehman Medical College",
    "Al-Razi Medical College",
    "Mohtarma Benazir Bhutto Shaheed Medical College",
    "Azad Jammu Kashmir Medical College",
    "Poonch Medical College",
    "Mohiuddin Islamic Medical College",
    "Université de Sétif",
    "University of Algiers",
    "University of Oran",
    "University of Constantine",
    "University of Batna ",
    "University of Blida ",
    "University of Mostaganem",
    "University of Annaba ",
    "University of Ouargla ",
    "Mouloud Mammeri University of Tizi Ouzou ",
    "Agostinho Neto University ",
    "University of Botswana School of Medicine ",
    "Institut Supérieur des Sciences de la Santé",
    "Unité de Formation et de Recherche en Sciences de la Santé",
    "Université Espoir d'Afrique",
    "Université de Ngozi",
    "Université du Burundi",
    "Faculty of medicine and biomedical sciences Yaounde",
    "Faculty of medicine and pharmaceutical sciences Douala",
    "Faculty of Health sciences Buea",
    "Université des Montagnes Bangante",
    "Institut Superieur de Technologie Medicales Nkololoum,Yaounde",
    "Faculty of Health Sciences Bamenda",
    "Catholic University of Cameroon (CATUC) Kumbo",
    "Faculte des sciences de la santé (Brazzaville)",
    "Université de Kinshasa Faculté de Médecine",
    "Université de Lubumbashi Faculté de Médecine",
    "Université de Kisangani Faculté de Médecine et Pharmacie",
    "Universite de Goma Faculte de Medecine",
    "Universite Officielle de Bukavu Faculte de Medecine et Pharmacie",
    "Universite Protestante du Congo Faculte de Medecine",
    "Université Shalom Bunia Faculté de Médecine",
    "Université Catholique du Graben Faculté de Médecine",
    "Universite Evangelique en Afrique Faculte de Medecine",
    "Universite Notre Dame du Kasai Faculte de Medecine",
    "Universite de Kindu Faculte de Medecine",
    "Universite de Bandundu Faculte de Medecine",
    "Université Kongo Faculté de Médecine",
    "Université Simon Kimbangu Faculté de médecine",
    "Université de Cocody",
    "Ain Shams University Faculty of Medicine",
    "Al-Azhar school of medicine in Assiut (for males), Al-Azhar University",
    "Al-Azhar school of medicine in Cairo (for males), Al-Azhar University",
    "Al-Azhar school of medicine in Cairo (for females), Al-Azhar University",
    "Al-Azhar school of medicine in Damietta (for males), Al-Azhar University",
    "Alexandria Faculty of Medicine",
    "Assiut Faculty of Medicine, Assiut University",
    "Benha Faculty of Medicine, Benha University",
    "Beni Suef Faculty of Medicine, Beni Suef University, Beni Suef",
    "Faculty of Medicine Zagazig University",
    "Fayoum Faculty of Medicine",
    "Kasr El-Aini Faculty of Medicine, Cairo University",
    "Mansoura Faculty of Medicine",
    "Minia Medical School",
    "Misr University for Science and Technology Faculty of Medicine",
    "Monoufia Faculty of Medicine",
    "Sohag Faculty of Medicine",
    "Suez Canal Faculty of Medicine",
    "Tanta Faculty of Medicine",
    "Orotta School of Medicine",
    "Bethel Medical College",
    "Adama University, Asella School of Medicine",
    "Addis Ababa University",
    "Gondar College of Medical Sciences",
    "Haramaya University",
    "Hayat Medical College",
    "Jimma University",
    "Hawassa University",
    "Mekelle University",
    "MyungSung Medical College",
    "St. Paul's Hospital Millennium Medical College",
    "Bahirdar University college of medicine \u0026 health science",
    "Madda Walabu University Goba Referral Hospital",
    "Wolaita Sodo University College of Health Science and Medicine",
    "Faculté de Médecine et des Sciences de la Santé",
    "Accra College of Medicine, Accra",
    "Kwame Nkrumah University of Science and Technology School of Medical Sciences, Kumasi",
    "School of Medicine and Health Sciences, University for Development Studies, Tamale",
    "University of Cape Coast School of Medical Sciences, Cape Coast",
    "University of Ghana Medical School, Accra",
    "University of Health and Allied Sciences School of Medicine, Ho",
    "Family Health Medical School,Teshie",
    "University of Nairobi Medical School",
    "Moi University Medical School",
    "Kenyatta University",
    "Egerton University Medical School",
    "Maseno University Medical School",
    "JKUAT Medical School",
    "Kenya Methodist University",
    "Uzima University College",
    "Kenya Medical Training College",
    "University of Liberia A. M. Dogliotti School of Medicine",
    "Libyan International Medical University",
    "Omar Al-Mukhtar University",
    "University of Benghazi",
    "University of Tripoli",
    "University of Malawi College of Medicine",
    "Anna Medical College and Research Centre",
    "Padmashree Dr D Y Patil Medical College",
    "Sir Seewoosagur Ramgoolam Medical College",
    "University of Mauritius",
    "Faculte de medecine de Nouckchott",
    "Faculté de médecine et de Pharmacie de Casablanca",
    "Faculté de médecine et de Pharmacie de Fes",
    "Faculté de médecine et de Pharmacie de Marrakech",
    "Faculté de médecine et de Pharmacie de Rabat",
    "Faculté de médecine et de Pharmacie d'Oujda",
    "Faculté de médecine et de Pharmacie de Tanger",
    "Université internationale Abulcasis des sciences de la santé",
    "Université Mohammed 6 des Sciences de la Santé",
    "Faculté de médecine privée de Marrakech",
    "Catholic University of Mozambique, Faculty of Medicine (Universidade Católica de Moçambique, Faculdade de Medicina)",
    "Eduardo Mondlane University, Faculty of Medicine (Universidade Eduardo Mondlane, Faculdade de Medicina)",
    "Lurio University, Health Science Faculty (Universidade Lurio, Faculdade de Ciências de Saúde)",
    "University of Namibia, Faculty of Medicine",
    "Abia State Uniersity, Uturu",
    "Afe Babalola",
    "African College of Health College of Medicine, FCT",
    "Ahmadu Bello University, Zaria",
    "Ambrose Alli University College of Medicine, Ekpoma",
    "Babcock University, Ilishan Remo, Ogun State Nigeria",
    "Bayero University, Kano",
    "Benue State University, College of Health Sciences, Makurdi, Benue State.",
    "Delta State University, Abraka",
    "Ebonyi State University, Abakaliki",
    "Edo University Iyamho, College of Health Science, Iyamho, Edo State.",
    "Ekiti State University, College of Medicine, Ado - Ekiti, Ekiti State.",
    "Enugu State University Of Science And Technology,College of Medicine, Parklane,Enugu.",
    "Igbinedion University, Okada, Edo State",
    "Ladoke Akintola University of Technology Lautech, Osogbo, Osun State",
    "Lagos State University, Ikeja, Lagos",
    "Madonna University, Elele, Rivers State",
    "Nnamdi Azikiwe University, Nnewi",
    "Obafemi Awolowo University, Ile-Ife",
    "Obafemi Awolowo College of Health Sciences, Olabisi Onabanjo University, Sagamu, Ogun State",
    "University of Medical Sciences, Ondo City, Ondo State (UNIMED)",
    "University of Benin",
    "University of Calabar",
    "University of Ibadan",
    "University of Ilorin",
    "University of Jos",
    "University of Lagos, Idi-Araba",
    "University of Maiduguri",
    "University of Nigeria, Enugu",
    "University of Port Harcourt",
    "Bingham University Karu",
    "University of Uyo, Uyo",
    "Usmanu Danfodiyo University",
    "Bowen University, Iwo",
    "Imo state University Owerri",
    "Sani Zangon Daura College of Health Technology, Daura, Katsina State",
    "Nile University of Nigeria, Abuja",
    "University of Rwanda",
    "University of Gitwe",
    "Université El Hadji Ibrahima Niasse, St. Christopher Iba Mar Diop College of Medicine ",
    "Somali National University",
    "Somali International University",
    "Salaam University",
    "Hargeisa University",
    "Amoud University",
    "Benadir University",
    "East Africa University",
    "Hope University",
    "Mogadishu University",
    "Somalia-Turkey Training and Research Hospital",
    "Baresan University",
    "East Africa University",
    "University of Somalia",
    "University of Health Science in Bosaso",
    "Edna Adan University",
    "Sefako Makgatho Health Sciences University",
    "University of Cape Town",
    "University of the Free State",
    "University of KwaZulu-Natal",
    "University of Limpopo",
    "University of Pretoria",
    "University of Stellenbosch",
    "University of the Witwatersrand",
    "Walter Sisulu University",
    "Catholic University of Health and Allied Sciences",
    "Hubert Kairuki Memorial University",
    "KCMC University College",
    "Muhimbili University of Health and Allied Sciences",
    "Saint Francis University of Health and Allied Sciences",
    "Saint Joseph College of Health Sciences",
    "University of Dodoma",
    "University of Dar es Salaam",
    "SHMS, State University of Zanzibar (SUZA)",
    "University of Monastir, Faculty of Medicine of Monastir",
    "University of Sfax, Faculty of Medicine of Sfax",
    "University of Sousse, Faculty of medicine Ibn El Jazzar of Sousse",
    "University of Tunis El Manar, Medicine School of Tunis",
    "University of Monastir, Faculty of dental medicine of Monastir",
    "Busitema University School of Medicine, Mbale",
    "Gulu University School of Medicine, Gulu",
    "Habib Medical School, Kibuli, Kampala",
    "International Health Sciences University, Namuwongo, Kampala",
    "Kampala International University School of Health Sciences, Bushenyi",
    "Makerere University School of Medicine, Mulago, Kampala",
    "Mbarara University School of Medicine, Mbarara",
    "Uganda Martyrs University School of Medicine, St. Francis Hospital Nsambya, Kampala",
    "Kabale University School of Medicine, Kabale",
    "Soroti University School of Health Sciences, Soroti",
    "Lusaka Apex Medical University, Lusaka",
    "Cavendish University School of Medicine, Lusaka",
    "Copperbelt University School of Medicine, Ndola",
    "University of Zambia School of Medicine, Lusaka",
    "Mulungushi University School of Medicine, Livingstone",
    "Texila American University - Zambia",
    "University of Zimbabwe College of Health Sciences",
    "Midlands State University Medical School",
    "National University of Science and Technology Medical School ",
    "Dubai Medical College for Girls",
    "Gulf Medical University",
    "Ajman University",
    "United Arab Emirates University",
    "University of Sharjah",
    "Mohammed Bin Rashid University of Medicine and Health Sciences",
    "Ras al-Khairmah Medical and Health Sciences University",
    "Weill Cornell Medical College in Qatar",
    "Qatar University",
    "Oman Medical College",
    "Sultan Qaboos University",
    "Kuwait University",
    "Lebanese University",
    "Beirut Arab University",
    "Saint Joseph University",
    "University of Balamand",
    "Lebanese American University",
    "American University of Beirut",
    "Holy Spirit University of Kaslik",
    "Bolan Medical and Dental College, Dental Section",
    "Khyber College of Dentistry",
    "KMU Institute of Dental Sciences",
    "Dental Section, Army Medical College",
    "Dental Section, Punjab Medical College",
    "Institute of Dentistry, Nishtar Medical College",
    "Liaquat University of Medical and Health Sciences",
    "Abbottabad International Medical Institute",
    "Peshawar Dental College",
    "Sardar Begum Dental College",
    "Bakhtawar Amin Medical College",
    "Bakhtawar Amin Dental College",
    "Nawaz Sharif Medical College",
    "Sharif Medical College",
    "Sharif Dental College",
    "Akhtar Saeed Medical and Dental College",
    "FMH College of Medicine and Dentistry",
    "Islamabad Medical and Dental College",
    "Multan Medical College",
    "Faryal Dental College",
    "Foundation University College of Dentistry",
    "HBS Dental College",
    "CMH Lahore Medical College",
    "Karachi Institute of Medical Sciences",
    "CMH Kharian Medical College",
    "CMH Institute of Medical Sciences Bahawalpur",
    "CMH Multan Institute of Medical Sciences",
    "Institute of Dentistry, CMH Lahore Medical College",
    "Islam Dental College",
    "Islamic International Dental College",
    "Margalla College of Dentistry",
    "Shahida Islam Medical College",
    "Shahida Islam Dental College",
    "Azra Naheed Dental College",
    "Shifa College of Dentistry",
    "Baqai Dental College",
    "Fatima Jinnah Medical University",
    "Ghulam Muhammad Mahar Medical College",
    "Isra Medical College Hyderabad",
    "Gambat Medical College",
    "Dow Dental College",
    "Dow International Dental College",
    "Dr. Ishrat-ul-Ebad Khan Institute of Oral Health Sciences",
    "Ziauddin College of Dentistry",
    "Sindh Institute of Oral Health Sciences",
    "Altamash Institute of Dental Medicine",
    "Jinnah Dental College",
    "Sir Syed Dental College",
    "Fatima Jinnah Dental College",
    "Liaquat College of Dentistry",
    "de'Montmorency College of Dentistry",
    "Muhammad Dental College",
    "Bahria Dental College",
    "Bibi Aseefa Dental College",
    "Watim Dental College",
    "Faculty of Dentistry, LUMHS",
    "Bhitai Dental College",
    "Isra Dental College",
    "Muhammad Dental College",
    "Federal Dental College",
    "Rawal College of Dentistry",
    "Women Dental College",
    "Abbottabad International College of Dentistry",
    "Bacha Khan Dental College",
    "Ayub Dental College",
    "Rehman College of Dentistry",
    "Frontier Dental College",
    "University College of Dentistry",
    "Dental College HITEC-IMS",
    "Bolan Medical College",
    "Suleman Roshan Medical College",
    "Bahawalpur Medical and Dental College",
    "Rai Medical College",
    "Watim Medical College",
    "M Islam Medical College",
    "Gajju Khan Medical College",
    "Abbotabad International Medical College",
    "Muhammad College of Medicine",
    "Niazi Medical College",
    "Sialkot Medical College",
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    filteredUniversities = List.from(universities);

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedUniversity = prefs.getString('selectedUniversity') ?? '';
      _selectedExamType = prefs.getString('selectedExamType');
      final dateString = prefs.getString('selectedDate');
      if (dateString != null) {
        _selectedDate = DateTime.parse(dateString);
        _startTimer(_selectedDate!);
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedUniversity', _selectedUniversity);
    if (_selectedExamType != null) {
      prefs.setString('selectedExamType', _selectedExamType!);
    }
    if (_selectedDate != null) {
      prefs.setString('selectedDate', _selectedDate!.toIso8601String());
    }
  }

  void _startTimer(DateTime date) {
    _timer?.cancel();
    _selectedDate = date;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = date.difference(now);
      if (difference.isNegative || difference.inSeconds <= 0) {
        setState(() {
          _timeLeft = '00:00:00:00';
        });
        timer.cancel();
      } else {
        final days = difference.inDays;
        final hours = difference.inHours.remainder(24);
        final minutes = difference.inMinutes.remainder(60);
        final seconds = difference.inSeconds.remainder(60);
        setState(() {
          _timeLeft = '$days : $hours : $minutes : $seconds';
        });
      }
    });
  }

  Future<void> showUniversitySelectionDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Your Dream Medical University'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search University...',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: PreMedColorTheme().red,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: PreMedColorTheme().red,
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value.toLowerCase();
                        filteredUniversities = universities
                            .where((university) => university.toLowerCase().contains(_searchText))
                            .toList();
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredUniversities.map((school) {
                          return ListTile(
                            title: Text(
                              school,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(school);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedUniversity = result;
      });
      _saveData();
      showExamTypeSelectionDialog(context);
    }
  }
  Future<void> showExamTypeSelectionDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Exam Type'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select The Exams You are \n Appearing for',
                        style: TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (_provincialMDCAT)
                            const Icon(Icons.check, color: Colors.blue, size: 18)
                          else
                            const SizedBox(width: 24),
                          const SizedBox(width: 10),
                          const Text('Provincial MDCAT'),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _provincialMDCAT = true;
                        _akuTest = false;
                        _numsTest = false;
                        _other = false;
                      });
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (_akuTest)
                            const Icon(Icons.check, color: Colors.blue, size: 18)
                          else
                            const SizedBox(width: 24),
                          const SizedBox(width: 10),
                          const Text('AKU Test'),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _provincialMDCAT = false;
                        _akuTest = true;
                        _numsTest = false;
                        _other = false;
                      });
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (_numsTest)
                            const Icon(Icons.check, color: Colors.blue, size: 18)
                          else
                            const SizedBox(width: 24),
                          const SizedBox(width: 10),
                          const Text('NUMS Test'),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _provincialMDCAT = false;
                        _akuTest = false;
                        _numsTest = true;
                        _other = false;
                      });
                    },
                  ),
                  ListTile(
                    title: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          if (_other)
                            const Icon(Icons.check, color: Colors.blue, size: 18)
                          else
                            const SizedBox(width: 24),
                          const SizedBox(width: 10),
                          const Text('Other'),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _provincialMDCAT = false;
                        _akuTest = false;
                        _numsTest = false;
                        _other = true;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 270,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: PreMedColorTheme().blue,
                      ),
                      onPressed: () {
                        if (_provincialMDCAT) {
                          Navigator.of(context).pop('Provincial MDCAT');
                        } else if (_akuTest) {
                          Navigator.of(context).pop('AKU Test');
                        } else if (_numsTest) {
                          Navigator.of(context).pop('NUMS Test');
                        } else if (_other) {
                          Navigator.of(context).pop('Other');
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedExamType = result;
      });
      _saveData();
      showDateSelectionDialog(context);
    }
  }
  Future<void> showDateSelectionDialog(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:  ColorScheme.light(
              primary: PreMedColorTheme().coolBlue,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _startTimer(selectedDate);
      });
      _saveData();
    }
  }

  Widget buildColon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            color: Colors.black54,
          ),
          const SizedBox(height: 4),
          Container(
            width: 8,
            height: 8,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> timeParts =
    _timeLeft.isNotEmpty ? _timeLeft.split(':') : [];
    return Center(
      child: Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 180, 180, 180).withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 7, left: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    PremedAssets.Badge,
                    height: 20,
                    width: 15,
                  ),
                  SizedBoxes.horizontalMicro,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TIME TO PREPARE FOR DREAM UNIVERSITY',
                        style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 12.8,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Text(
                          _selectedUniversity,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700,
                            color: PreMedColorTheme().blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBoxes.verticalTiny,
              if (_selectedDate != null && timeParts.length == 4)
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      )
                    ],
                  ),
                  height: 72,
                  width: 312,
                  child: Card(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeParts[0],
                            style:  TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: PreMedColorTheme().blue,
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[1],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[2],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            timeParts[3],
                            style:  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 72,
                  width: 312,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      )
                    ],
                  ),
                  child: Card(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                          SizedBoxes.horizontalMedium,
                          buildColon(),
                          SizedBoxes.horizontalMedium,
                          Text(
                            "00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: PreMedColorTheme().blue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBoxes.verticalTiny,
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    )
                  ],
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().red
                          : PreMedColorTheme().blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      )
                  ),
                  onPressed: () async {
                    await showUniversitySelectionDialog(context);
                  },
                  child: const Text(
                    'Set/Change Goal',
                    style: TextStyle(fontSize: 16,fontFamily: 'Rubik'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}