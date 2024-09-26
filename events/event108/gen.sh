lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.65805805805806 --fixed-mass2 69.85545545545546 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001523336.6873894 \
--gps-end-time 1001530536.6873894 \
--d-distr volume \
--min-distance 1163.59658425078e3 --max-distance 1163.61658425078e3 \
--l-distr fixed --longitude 86.22203826904297 --latitude -27.93789291381836 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
