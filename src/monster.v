import os
import io 

fn main(){
	mut file := os.open("MonsterFile") ?
	mut data := []string{}
	mut read_data := io.new_buffered_reader(reader: file)
	for {
		l := read_data.read_line() or { break }
		data << l
	}
	mut chars := []string{}
	for i in data{
		mut str := []string{}
		for char in i{
			if rune(char).str() != " "{
				str << rune(char).str()
			}
		}
		chars << str
	}
	mut tags := []string{}
	mut files := []string{}
	mut option := ""
	for i in chars{
		if i != ";" && i != ":"{
			option += i
		} else if i == ":" {
			tags << option
			option = ""
		} else if i == ";"{
			files << option
			option = ""
		}
	}
	mut tagdata := ""
	mut tag_output := []string{}
	unsafe {
		mut open_files := []os.File{}
		for i in files {
			open_files << os.open(i) ?
		}
		for i in open_files{
			mut file_data := io.new_buffered_reader(reader: i)
			for {
				l := file_data.read_line() or { break }
				tagdata += l
			}
			tag_output << tagdata
			tagdata = ""
		}
	}
	output := os.args[1]
	mut data_to_write := []byte{}
	for i in tag_output{
		data_to_write << i.bytes()
	}
	export := os.open_file(output, "w") ?
	mut export_data := io.new_multi_writer(export)
	export_data.write(data_to_write) ?
}