lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.461901901901903 --fixed-mass2 60.02230230230231 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006459316.3233607 \
--gps-end-time 1006466516.3233607 \
--d-distr volume \
--min-distance 999.0422564565921e3 --max-distance 999.0622564565921e3 \
--l-distr fixed --longitude 104.31766510009766 --latitude 60.698333740234375 --i-distr uniform \
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
