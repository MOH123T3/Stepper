// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:timer_button/timer_button.dart';
import 'package:userapp_7mantra/Utils/Utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UsingAadhar extends StatefulWidget {
  const UsingAadhar({Key? key}) : super(key: key);

  @override
  State<UsingAadhar> createState() => _UsingAadharState();
}

class _UsingAadharState extends State<UsingAadhar> {
  int currentStep = 0;

  TextEditingController AadharController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  bool mobileFieldVisible = false;
  bool otpFieldVisible = true;
  bool mobileError = false;
  bool titleError = false;
  bool _aadharVisible = false;
  bool _value = false;
  int numberOfFields = 6;

  var Value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpFieldVisible = true;
    _aadharVisible = false;
    titleError = false;
    mobileError = false;
  }

  Widget controlsBuilder(context, details) {
    return Column(
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.primarycolor,
        appBar: AppBar(
          backgroundColor: Utils.primarycolor,
          title: Text('Create ABHA Number '),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Utils.centertext(
                    "Create ABHA Number", 18, FontWeight.bold, Colors.black),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Theme(
                  data: ThemeData(canvasColor: Colors.white),
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: currentStep,
                    controlsBuilder: controlsBuilder,
                    // onStepTapped: (state) {
                    //   setState(() {
                    //     currentStep = state;
                    //   });
                    // },
                    onStepContinue: () {
                      if (currentStep < 2) {
                        setState(() {
                          currentStep = currentStep + 1;
                        });
                      }
                    },
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() => currentStep -= 1),
                    steps: getSteps(),
                  ),
                )),
              ],
            ),
          ),
        ));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text("Consent Collection"),
            content: consentCollection()),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Aadhaar Authentication"),
          content: aadharAuthentication(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text("Profile Completion"),
          content: profileCompletion(),
        )
      ];

  // Step 1

  consentCollection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              obscureText: !_aadharVisible,
              controller: AadharController,
              maxLength: 12,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  AadharController.value.text.toString().trim() == ""
                      ? titleError = true
                      : titleError = false;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: titleError
                      ? " Please enter 12 digits Aadhaar Number "
                      : AadharController.value.text.length < 12
                          ? null
                          : null,
                  labelText: "Aadhaar Number",
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  hintText: 'Aadhaar Number',
                  suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _aadharVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _aadharVisible = !_aadharVisible;
                        });
                      })),
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "I, hereby declare that I am voluntarily sharing my Aadhaar Number and demographic information issued by UIDAI, with National Health Authority (NHA) for the sole purpose of creation of ABHA number . I understand that my ABHA number can be used and shared for purposes as may be notified by ABDM from time to time including provision of healthcare services. Further, I am aware that my personal identifiable information (Name, Address, Age, Date of Birth, Gender and Photograph) may be made available to the entities working in the National Digital Health Ecosystem (NDHE) which inter alia includes stakeholders and entities such as healthcare professionals (e.g. doctors), facilities (e.g. hospitals, laboratories) and data fiduciaries (e.g. health programmes), which are registered with or linked to the Ayushman Bharat Digital Mission (ABDM), and various processes there under. I authorize NHA to use my Aadhaar number for performing Aadhaar based authentication with UIDAI as per the provisions of the Aadhaar (Targeted Delivery of Financial and other Subsidies, Benefits and Services) Act, 2016 for the aforesaid purpose. I understand that UIDAI will share my e-KYC details, or response of “Yes” with NHA upon successful authentication. I have been duly informed about the option of using other IDs apart from Aadhaar; however, I consciously choose to use Aadhaar number for the purpose of availing benefits across the NDHE. I am aware that my personal identifiable information excluding Aadhaar number / VID number can be used and shared for purposes as mentioned above. I reserve the right to revoke the given consent at any point of time as per provisions of Aadhaar Act and Regulations.",
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Checkbox(
                    value: this._value,
                    onChanged: (value) {
                      setState(() {
                        this._value = value!;
                      });
                    }),
                Utils.centertext("i agree", 15, FontWeight.bold, Colors.black)
              ],
            )
          ],
        ),
        SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    if (AadharController.value.text.toString().trim() == "" ||
                        AadharController.value.text.length < 12) {
                      titleError = true;
                    } else {
                      titleError = false;

                      if (_value == true) {
                        currentStep = currentStep + 1;
                      } else {
                        print("else");

                        Utils.getToast(
                            "Agree with the Term and Condition.",
                            Colors.black,
                            Toast.LENGTH_SHORT,
                            16,
                            Utils.primarycolor,
                            ToastGravity.BOTTOM);
                      }
                    }
                  });
                },
                child: Utils.btn("Next"))
          ],
        ),
      ],
    );
  }

// step 2

  aadharAuthentication() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: otpFieldVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Utils.centertext(
                  "We just sent an OTP on the Mobile Number linked with your Aadhaar.",
                  18,
                  FontWeight.bold,
                  Colors.black),
              SizedBox(
                height: 60,
              ),
              Utils.centertext("Enter OTP", 18, FontWeight.bold, Colors.black),
              SizedBox(
                height: 20,
              ),
              OtpTextField(
                clearText: true,
                autoFocus: true,
                filled: true,
                onSubmit: (value) {},
                fieldWidth: 60,
                textStyle: TextStyle(fontSize: 20),
                numberOfFields: numberOfFields,
                borderColor: Utils.primarycolor,
                showFieldAsBox: true,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: TimerButton(
                  activeTextStyle: TextStyle(
                      color: Utils.primarycolor, fontWeight: FontWeight.bold),
                  disabledColor: Colors.white,
                  disabledTextStyle: TextStyle(color: Colors.black),
                  color: Colors.white,
                  buttonType: ButtonType.TextButton,
                  timeOutInSeconds: 120,
                  label: 'Resend OTP',
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          setState(() {
                            currentStep = currentStep - 1;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        label: Utils.centertext(
                          "Back",
                          18,
                          FontWeight.normal,
                          Colors.black,
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            mobileFieldVisible = true;
                            otpFieldVisible = false;
                          });
                        },
                        child: Utils.btn("Next"))
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: mobileFieldVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Utils.centertext(
                    "It is recommended that you use the Mobile Number linked with Aadhaar.",
                    18,
                    FontWeight.bold,
                    Colors.black),
                SizedBox(
                  height: 60,
                ),
                Utils.centertext("Enter Your Mobile Number", 18,
                    FontWeight.bold, Colors.black),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 70, top: 20, bottom: 20),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          mobileNumberController.value.text.toString().trim() ==
                                  ""
                              ? mobileError = true
                              : mobileError = false;
                        });
                      },
                      controller: mobileNumberController,
                      maxLength: 10,
                      obscureText: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          errorText: mobileError
                              ? " Please enter 10 digits Mobile Number "
                              : mobileNumberController.value.text.length < 10
                                  ? null
                                  : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          hintText: 'Enter Your Mobile Number',
                          labelText: 'Enter Your Mobile Number')),
                ),
                SizedBox(
                  height: 20,
                ),
                Utils.centertext(
                    "This Mobile Number will be used to authenticate your ABHA number.",
                    15,
                    FontWeight.bold,
                    Colors.black),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              mobileFieldVisible = false;
                              otpFieldVisible = true;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          label: Utils.centertext(
                            "Back",
                            18,
                            FontWeight.normal,
                            Colors.black,
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (mobileNumberController.value.text
                                          .toString()
                                          .trim() ==
                                      "" ||
                                  mobileNumberController.value.text.length <
                                      10) {
                                mobileError = true;
                              } else {
                                mobileError = false;

                                currentStep = currentStep + 1;
                              }
                            });
                          },
                          child: Utils.btn("Next"))
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }

// Step 3

  profileCompletion() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 40,
          ),
          Utils.centertext("Your Profile Details (As in Aadhaar)", 20,
              FontWeight.bold, Colors.black),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Utils.centertext(" Aadhaar Authentication Successful", 18,
                  FontWeight.normal, Colors.black),
              SizedBox(
                width: 10,
              ),
              Image(
                  height: 30,
                  width: 25,
                  image: AssetImage('asset/images/greentickiconpng.png'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Utils.primarycolor,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.centertext(
                        "Full Name", 18, FontWeight.bold, Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Utils.centertext(
                        "Ram Singh", 16, FontWeight.normal, Colors.black),
                    SizedBox(
                      height: 30,
                    ),
                    Utils.centertext(
                        "Date of Birth", 18, FontWeight.bold, Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Utils.centertext(
                        "10/11/1998", 16, FontWeight.normal, Colors.black),
                    SizedBox(
                      height: 30,
                    ),
                    Utils.centertext(
                        "Address", 18, FontWeight.bold, Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Gujarat, Ahamdabad ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.centertext(
                        "Gender", 18, FontWeight.bold, Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    Utils.centertext(
                        "Male", 16, FontWeight.normal, Colors.black),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Image(
                  height: 150,
                  width: 150,
                  image: AssetImage("asset/images/imgprofile.gif"))
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () {
                      setState(() {
                        currentStep = currentStep - 1;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    label: Utils.centertext(
                      "Back",
                      18,
                      FontWeight.normal,
                      Colors.black,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/memberBeneficiary');
                    },
                    child: Utils.btn("Next"))
              ],
            ),
          ),
        ]);
  }
}
