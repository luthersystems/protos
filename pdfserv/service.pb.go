// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.30.0
// 	protoc        (unknown)
// source: pdfserv/service.proto

package pdfserv

import (
	common "github.com/luthersystems/protos/common"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

var File_pdfserv_service_proto protoreflect.FileDescriptor

var file_pdfserv_service_proto_rawDesc = []byte{
	0x0a, 0x15, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x2f, 0x73, 0x65, 0x72, 0x76, 0x69, 0x63,
	0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x07, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76,
	0x1a, 0x18, 0x63, 0x6f, 0x6d, 0x6d, 0x6f, 0x6e, 0x2f, 0x68, 0x65, 0x61, 0x6c, 0x74, 0x68, 0x63,
	0x68, 0x65, 0x63, 0x6b, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x15, 0x70, 0x64, 0x66, 0x73,
	0x65, 0x72, 0x76, 0x2f, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x2e, 0x70, 0x72, 0x6f, 0x74,
	0x6f, 0x32, 0x98, 0x01, 0x0a, 0x03, 0x50, 0x44, 0x46, 0x12, 0x4e, 0x0a, 0x0b, 0x48, 0x65, 0x61,
	0x6c, 0x74, 0x68, 0x43, 0x68, 0x65, 0x63, 0x6b, 0x12, 0x1d, 0x2e, 0x63, 0x6f, 0x6d, 0x6d, 0x6f,
	0x6e, 0x2e, 0x47, 0x65, 0x74, 0x48, 0x65, 0x61, 0x6c, 0x74, 0x68, 0x43, 0x68, 0x65, 0x63, 0x6b,
	0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x1e, 0x2e, 0x63, 0x6f, 0x6d, 0x6d, 0x6f, 0x6e,
	0x2e, 0x47, 0x65, 0x74, 0x48, 0x65, 0x61, 0x6c, 0x74, 0x68, 0x43, 0x68, 0x65, 0x63, 0x6b, 0x52,
	0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x12, 0x41, 0x0a, 0x08, 0x47, 0x65, 0x6e,
	0x65, 0x72, 0x61, 0x74, 0x65, 0x12, 0x18, 0x2e, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x2e,
	0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a,
	0x19, 0x2e, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x2e, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61,
	0x74, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x42, 0x80, 0x01, 0x0a,
	0x0b, 0x63, 0x6f, 0x6d, 0x2e, 0x70, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x42, 0x0c, 0x53, 0x65,
	0x72, 0x76, 0x69, 0x63, 0x65, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01, 0x5a, 0x27, 0x67, 0x69,
	0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x6c, 0x75, 0x74, 0x68, 0x65, 0x72, 0x73,
	0x79, 0x73, 0x74, 0x65, 0x6d, 0x73, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x73, 0x2f, 0x70, 0x64,
	0x66, 0x73, 0x65, 0x72, 0x76, 0xa2, 0x02, 0x03, 0x50, 0x58, 0x58, 0xaa, 0x02, 0x07, 0x50, 0x64,
	0x66, 0x73, 0x65, 0x72, 0x76, 0xca, 0x02, 0x07, 0x50, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0xe2,
	0x02, 0x13, 0x50, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x5c, 0x47, 0x50, 0x42, 0x4d, 0x65, 0x74,
	0x61, 0x64, 0x61, 0x74, 0x61, 0xea, 0x02, 0x07, 0x50, 0x64, 0x66, 0x73, 0x65, 0x72, 0x76, 0x62,
	0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var file_pdfserv_service_proto_goTypes = []interface{}{
	(*common.GetHealthCheckRequest)(nil),  // 0: common.GetHealthCheckRequest
	(*GenerateRequest)(nil),               // 1: pdfserv.GenerateRequest
	(*common.GetHealthCheckResponse)(nil), // 2: common.GetHealthCheckResponse
	(*GenerateResponse)(nil),              // 3: pdfserv.GenerateResponse
}
var file_pdfserv_service_proto_depIdxs = []int32{
	0, // 0: pdfserv.PDF.HealthCheck:input_type -> common.GetHealthCheckRequest
	1, // 1: pdfserv.PDF.Generate:input_type -> pdfserv.GenerateRequest
	2, // 2: pdfserv.PDF.HealthCheck:output_type -> common.GetHealthCheckResponse
	3, // 3: pdfserv.PDF.Generate:output_type -> pdfserv.GenerateResponse
	2, // [2:4] is the sub-list for method output_type
	0, // [0:2] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_pdfserv_service_proto_init() }
func file_pdfserv_service_proto_init() {
	if File_pdfserv_service_proto != nil {
		return
	}
	file_pdfserv_pdfserv_proto_init()
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_pdfserv_service_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   0,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_pdfserv_service_proto_goTypes,
		DependencyIndexes: file_pdfserv_service_proto_depIdxs,
	}.Build()
	File_pdfserv_service_proto = out.File
	file_pdfserv_service_proto_rawDesc = nil
	file_pdfserv_service_proto_goTypes = nil
	file_pdfserv_service_proto_depIdxs = nil
}
