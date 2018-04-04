#!/usr/bin/ruby
# coding: utf-8

require 'kconv'

car = Hash.new()
spec = Array.new(13)

require "csv"

CSV.foreach("supercarboom.csv",headers:true, :converters => :numeric){|cardata|
  car[cardata[0]] = cardata[1..-1]
  car[cardata[0]] << cardata[4]/cardata[7]
}

STDERR.print("駆動方式は(指定なしの場合は空で)?: ")
drive = gets.chomp
STDERR.print("メーカーは(指定なしの場合は空で)?: ")
maker = gets.chomp

if drive > ""			
  ptn = Regexp.new(drive)
  car = car.select {|k, v| ptn =~ v[12]}
end
if maker > ""			
  ptn = Regexp.new(maker)	
  car = car.select {|k, v| ptn =~ v[0]}
end

puts("                                 【車種一覧】")
car.each {|key, value|
  printf("%s %sの情報 %s
            メーカー: %s
            販売開始: %s 年
            生産台数: %d 台
            重量:     %d kg
            最高速度: %d km/h
            最大出力: %d cc 
            最大馬力: %d ps 
            最大トルク: %d kgm
            全長:     %d mm
            全幅:     %d mm
            全高:     %d mm
            ホイールベース: %d mm
            駆動方式: %s
            エンジン: %s
            PWR: %f kg/ps\n","="*25,key,"="*25,*car[key])
}
