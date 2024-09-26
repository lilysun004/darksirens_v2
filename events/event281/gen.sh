lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.153793793793795 --fixed-mass2 46.407167167167174 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005707504.535596 \
--gps-end-time 1005714704.535596 \
--d-distr volume \
--min-distance 1631.9557082795934e3 --max-distance 1631.9757082795934e3 \
--l-distr fixed --longitude -32.818115234375 --latitude 17.784320831298828 --i-distr uniform \
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
